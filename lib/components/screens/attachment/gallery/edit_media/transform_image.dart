import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:buzzchat/components/screens/attachment/gallery/edit_media/crop_painter.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

enum SelectedHandle {
  none,
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center
}

class TransformImage extends StatefulWidget {
  final String imagePath;
  const TransformImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  _TransformImageState createState() => _TransformImageState();
}

class _TransformImageState extends State<TransformImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  late Animation<double> sizeAnimation;

  GlobalKey imageKey = GlobalKey();

  Rect? imageRect;
  Rect? cropRect;
  Rect? cropRectCopy;
  Rect? painterRect;
  Size? sizeAfterRotation;

  SelectedHandle selectedHandle = SelectedHandle.none;
  double rotateAngle = 0;
  int normalizedAngle = 0;
  void _getImageIntrinsicDimensions() async {
    final Image image = Image.file(
      File(widget.imagePath),
      fit: BoxFit.scaleDown,
      height: imageRect?.height,
      width: imageRect?.width,
    );
    final Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );
    Size? intrinsicSize;

    intrinsicSize = await completer.future;

    if (imageRect != null) {
      double intrinsicWidth = intrinsicSize.width;
      double intrinsicHeight = intrinsicSize.height;
      double widgetWidth = imageRect!.height;
      double widgetHeight = imageRect!.width;

      double widthScale = widgetWidth / intrinsicWidth;
      double heightScale = widgetHeight / intrinsicHeight;
      double scale = widthScale < heightScale ? widthScale : heightScale;

      setState(() {
        sizeAfterRotation =
            Size(intrinsicWidth * scale, intrinsicHeight * scale);
      });
    }

    setState(() {});
  }

  void rotateImage() {
    setState(() {
      rotateAngle += (90 * pi) / 180;
    });
    // Convert radians to degrees for readability
    int angleInDegrees = ((rotateAngle * 180) / pi).toInt();

    // Normalize the angle to be within 0 to 360 degrees

    setState(() {
      normalizedAngle = (angleInDegrees % 360).toInt();

      imageRect = Rect.fromLTWH(0, 0, imageRect!.height, imageRect!.width);

      _getImageIntrinsicDimensions();
      painterRect = Rect.fromLTWH(
          0, 0, sizeAfterRotation!.width, sizeAfterRotation!.height);

      double scaleX = sizeAfterRotation!.width / imageRect!.height;
      double scaleY = sizeAfterRotation!.height / imageRect!.width;
      double scale = min(scaleX, scaleY);

      if (normalizedAngle == 0 ||
          normalizedAngle == 180 ||
          normalizedAngle == 360) {
        scaleX = imageRect!.width / sizeAfterRotation!.height;
        scaleY = imageRect!.height / sizeAfterRotation!.width;
        scale = max(scaleX, scaleY);
      }

      cropRect = Rect.fromLTWH(cropRect!.left * scale, cropRect!.top * scale,
          cropRect!.width * scale, cropRect!.height * scale);
    });
    animationController.forward();
  }

  void handlePanStart(DragStartDetails details) {
    if ((details.localPosition - cropRect!.topCenter).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.top;
      });
    } else if ((details.localPosition - cropRect!.bottomCenter).distance <=
        40) {
      setState(() {
        selectedHandle = SelectedHandle.bottom;
      });
    } else if ((details.localPosition - cropRect!.centerLeft).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.left;
      });
    } else if ((details.localPosition - cropRect!.centerRight).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.right;
      });
    } else if ((details.localPosition - cropRect!.topLeft).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.topLeft;
      });
    } else if ((details.localPosition - cropRect!.topRight).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.topRight;
      });
    } else if ((details.localPosition - cropRect!.bottomLeft).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.bottomLeft;
      });
    } else if ((details.localPosition - cropRect!.bottomRight).distance <= 40) {
      setState(() {
        selectedHandle = SelectedHandle.bottomRight;
      });
    } else if ((details.localPosition - cropRect!.center).distance <=
        (cropRect!.width * 0.4)) {
      setState(() {
        selectedHandle = SelectedHandle.center;
      });
    }
  }

  void handlePanEnd(DragEndDetails details) {
    setState(() {
      selectedHandle = SelectedHandle.none;
    });
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    if (selectedHandle == SelectedHandle.top) {
      setState(() {
        // Calculate new top position based on drag direction
        double newTop = cropRect!.top + details.delta.dy;

        if (newTop <= painterRect!.top) {
          newTop = painterRect!.top;
        } else if (newTop >= painterRect!.bottom) {
          newTop = painterRect!.bottom - cropRect!.height;
        }
        // Adjust height to respect minimum height requirement
        if ((cropRect!.bottom - newTop) <= 20) {
          newTop = cropRect!.top;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          cropRect!.left,
          newTop,
          cropRect!.right,
          cropRect!.bottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.bottom) {
      setState(() {
        // Calculate new top position based on drag direction
        double newBottom = cropRect!.bottom + details.delta.dy;

        if (newBottom >= painterRect!.bottom) {
          newBottom = painterRect!.bottom;
        } else if (newBottom <= painterRect!.top) {
          newBottom = painterRect!.top - cropRect!.height;
        }
        if ((newBottom - cropRect!.top) <= 20) {
          newBottom = cropRect!.bottom;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          cropRect!.left,
          cropRect!.top,
          cropRect!.right,
          newBottom,
        );
      });
    }
  }

  void handleHorizontalDragUpdate(DragUpdateDetails details) {
    if (selectedHandle == SelectedHandle.left) {
      setState(() {
        // Calculate new top position based on drag direction

        double newLeft = cropRect!.left + details.delta.dx;

        if (newLeft <= painterRect!.left) {
          newLeft = painterRect!.left;
        } else if (newLeft >= painterRect!.right) {
          newLeft = painterRect!.right - cropRect!.width;
        }

        if ((cropRect!.right - newLeft) <= 20) {
          newLeft = cropRect!.left;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          newLeft,
          cropRect!.top,
          cropRect!.right,
          cropRect!.bottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.right) {
      setState(() {
        // Calculate new top position based on drag direction
        double newRight = cropRect!.right + details.delta.dx;

        if (newRight >= painterRect!.right) {
          newRight = painterRect!.right;
        } else if (newRight <= painterRect!.left) {
          newRight = painterRect!.left + cropRect!.width;
        }

        if ((newRight - cropRect!.left) <= 20) {
          newRight = cropRect!.right;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          cropRect!.left,
          cropRect!.top,
          newRight,
          cropRect!.bottom,
        );
      });
    }
  }

  void handleDiagonalDragUpdate(DragUpdateDetails details) {
    if (selectedHandle == SelectedHandle.topLeft) {
      setState(() {
        // Calculate new top position based on drag direction

        double newTop = cropRect!.top + details.delta.dy;
        double newLeft = cropRect!.left + details.delta.dx;

        if (newTop <= painterRect!.top) {
          newTop = painterRect!.top;
        } else if (newTop >= painterRect!.bottom) {
          newTop = painterRect!.bottom - cropRect!.height;
        }
        if (newLeft <= painterRect!.left) {
          newLeft = painterRect!.left;
        } else if (newLeft >= painterRect!.right) {
          newLeft = painterRect!.right - cropRect!.width;
        }

        if ((cropRect!.right - newLeft) <= 20) {
          newLeft = cropRect!.left;
        }
        if ((cropRect!.bottom - newTop) <= 20) {
          newTop = cropRect!.top;
        }

        // Update cropRect
        cropRect = Rect.fromLTRB(
          newLeft,
          newTop,
          cropRect!.right,
          cropRect!.bottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.topRight) {
      setState(() {
        // Calculate new top position based on drag direction

        double newTop = cropRect!.top + details.delta.dy;
        double newRight = cropRect!.right + details.delta.dx;

        if (newTop <= painterRect!.top) {
          newTop = painterRect!.top;
        } else if (newTop >= painterRect!.bottom) {
          newTop = painterRect!.bottom - cropRect!.height;
        }
        if (newRight >= painterRect!.right) {
          newRight = painterRect!.right;
        } else if (newRight <= painterRect!.left) {
          newRight = painterRect!.left + cropRect!.width;
        }

        if ((cropRect!.bottom - newTop) <= 20) {
          newTop = cropRect!.top;
        }
        if ((newRight - cropRect!.left) <= 20) {
          newRight = cropRect!.right;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          cropRect!.left,
          newTop,
          newRight,
          cropRect!.bottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.bottomLeft) {
      setState(() {
        // Calculate new top position based on drag direction

        double newBottom = cropRect!.bottom + details.delta.dy;
        double newLeft = cropRect!.left + details.delta.dx;

        if (newBottom >= painterRect!.bottom) {
          newBottom = painterRect!.bottom;
        } else if (newBottom <= painterRect!.top) {
          newBottom = painterRect!.top - cropRect!.height;
        }
        if (newLeft <= painterRect!.left) {
          newLeft = painterRect!.left;
        } else if (newLeft >= painterRect!.right) {
          newLeft = painterRect!.right - cropRect!.width;
        }

        if ((cropRect!.right - newLeft) <= 20) {
          newLeft = cropRect!.left;
        }
        if ((newBottom - cropRect!.top) <= 20) {
          newBottom = cropRect!.bottom;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          newLeft,
          cropRect!.top,
          cropRect!.right,
          newBottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.bottomRight) {
      setState(() {
        // Calculate new top position based on drag direction

        double newBottom = cropRect!.bottom + details.delta.dy;
        double newRight = cropRect!.right + details.delta.dx;

        if (newBottom >= painterRect!.bottom) {
          newBottom = painterRect!.bottom;
        } else if (newBottom <= painterRect!.top) {
          newBottom = painterRect!.top - cropRect!.height;
        }
        if (newRight >= painterRect!.right) {
          newRight = painterRect!.right;
        } else if (newRight <= painterRect!.left) {
          newRight = painterRect!.left + cropRect!.width;
        }

        if ((newBottom - cropRect!.top) <= 20) {
          newBottom = cropRect!.bottom;
        }
        if ((newRight - cropRect!.left) <= 20) {
          newRight = cropRect!.right;
        }
        // Update cropRect
        cropRect = Rect.fromLTRB(
          cropRect!.left,
          cropRect!.top,
          newRight,
          newBottom,
        );
      });
    } else if (selectedHandle == SelectedHandle.center) {
      setState(() {
        // Calculate new positions based on delta values
        double newLeft = cropRect!.left + details.delta.dx;
        double newTop = cropRect!.top + details.delta.dy;
        double newRight = newLeft + cropRect!.width;
        double newBottom = newTop + cropRect!.height;

        // Limit movement within painterRect boundaries
        if (newLeft < painterRect!.left) {
          newLeft = painterRect!.left;
          newRight = newLeft + cropRect!.width;
        } else if (newRight > painterRect!.right) {
          newRight = painterRect!.right;
          newLeft = newRight - cropRect!.width;
        }

        if (newTop < painterRect!.top) {
          newTop = painterRect!.top;
          newBottom = newTop + cropRect!.height;
        } else if (newBottom > painterRect!.bottom) {
          newBottom = painterRect!.bottom;
          newTop = newBottom - cropRect!.height;
        }

        // Update cropRect
        cropRect = Rect.fromLTRB(
          newLeft,
          newTop,
          newRight,
          newBottom,
        );
      });
    }
  }

  void handlePanUpdate(DragUpdateDetails details) {
    handleHorizontalDragUpdate(details);
    handleVerticalDragUpdate(details);
    handleDiagonalDragUpdate(details);
  }

  void calculateSizeAndPosition() {
    final RenderBox renderBox =
        imageKey.currentContext?.findRenderObject() as RenderBox;

    setState(() {
      painterRect =
          Rect.fromLTWH(0, 0, renderBox.size.width, renderBox.size.height);
      imageRect =
          Rect.fromLTWH(0, 0, renderBox.size.width, renderBox.size.height);
      cropRect =
          Rect.fromLTWH(0, 0, renderBox.size.width, renderBox.size.height);

      cropRectCopy = cropRect;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateSizeAndPosition();
      _getImageIntrinsicDimensions();
    });
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    rotationAnimation =
        Tween<double>(begin: 0, end: rotateAngle).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;

    double width = MediaQuery.of(context).size.width;

    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: BuzzChatPalette.grayscale.grayscale100,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: rotateAngle),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: Transform.scale(
                          scale: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              imageRect != null
                                  ? TweenAnimationBuilder(
                                      tween: Tween<double?>(
                                          begin: 0, end: imageRect?.height),
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                      builder: (context, value, child) {
                                        return Image.file(
                                          File(widget.imagePath),
                                          fit: BoxFit.scaleDown,
                                          key: imageKey,
                                          height: value,
                                        );
                                      })
                                  : Image.file(
                                      File(widget.imagePath),
                                      fit: BoxFit.scaleDown,
                                      key: imageKey,
                                      height: imageRect?.height,
                                    ),
                              imageRect != null
                                  ? GestureDetector(
                                      onPanUpdate: handlePanUpdate,
                                      onPanStart: handlePanStart,
                                      onPanEnd: handlePanEnd,
                                      child: CustomPaint(
                                        size: Size(painterRect!.width,
                                            painterRect!.height),
                                        painter: CropPainter(
                                            cropRect!, painterRect!),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ))),
          Container(
            padding: EdgeInsets.only(bottom: 16),
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      minimumSize: Size.zero,
                      foregroundColor: BuzzChatPalette.grayscale.grayscale1000),
                ),
                IconButton(
                  onPressed: () {
                    rotateImage();
                  },
                  icon: Icon(Icons.rotate_90_degrees_ccw_rounded),
                  color: BuzzChatPalette.grayscale.grayscale1000,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      minimumSize: Size.zero,
                      foregroundColor: BuzzChatPalette.grayscale.grayscale1000),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
