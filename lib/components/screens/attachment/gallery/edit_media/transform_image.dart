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

class _TransformImageState extends State<TransformImage> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey containerKey = GlobalKey();

  Rect? imageRect;
  Rect? cropRect;

  Rect? painterRect;
  Size? sizeAfterRotation;
  double scaleImage = 1;

  Offset translateImage = Offset.zero;
  bool animateCropRect = false;

  SelectedHandle selectedHandle = SelectedHandle.none;

  double rotateAngle = 0;
  int normalizedAngle = 0;
  Size? sizeBeforeRotation;
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

    // print((imageKey.currentContext?.findRenderObject() as RenderBox)
    //     .localToGlobal(Offset.zero));
    if (imageRect != null) {
      double intrinsicWidth = intrinsicSize.width;
      double intrinsicHeight = intrinsicSize.height;
      double widgetWidthBeforeRotation = imageRect!.width;
      double widgetHeightBeforeRotation = imageRect!.height;

      double widgetWidthAfterRotation = imageRect!.height;
      double widgetHeightAfterRotation = imageRect!.width;

      double widthBeforeRotationScale =
          widgetWidthBeforeRotation / intrinsicWidth;
      double heightBeforeRotationScale =
          widgetHeightBeforeRotation / intrinsicHeight;

      double widthAfterRotationScale =
          widgetWidthAfterRotation / intrinsicWidth;
      double heightAfterRotationScale =
          widgetHeightAfterRotation / intrinsicHeight;
      double scaleBeforeRotation =
          widthBeforeRotationScale < heightBeforeRotationScale
              ? widthBeforeRotationScale
              : heightBeforeRotationScale;
      double scaleAfterRotation =
          widthAfterRotationScale < heightAfterRotationScale
              ? widthAfterRotationScale
              : heightAfterRotationScale;

      setState(() {
        sizeAfterRotation = Size(intrinsicWidth * scaleAfterRotation,
            intrinsicHeight * scaleAfterRotation);
        sizeBeforeRotation = Size(intrinsicWidth * scaleBeforeRotation,
            intrinsicHeight * scaleBeforeRotation);

        // print(intrinsicImageRectAfterRotation);
        // print(intrinsicImageRectBeforeRotation);
      });
    }
  }

  void rotateImage() {
    setState(() {
      rotateAngle += (90 * pi) / 180;
      animateCropRect = true;
    });
    // Convert radians to degrees for readability
    int angleInDegrees = ((rotateAngle * 180) / pi).toInt();

    // Normalize the angle to be within 0 to 360 degrees

    final RenderBox containerRenderBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;

    setState(() {
      normalizedAngle = (angleInDegrees % 360).toInt();

      imageRect = Rect.fromLTWH(0, 0, imageRect!.height, imageRect!.width);
      _getImageIntrinsicDimensions();
      painterRect = Rect.fromLTWH(
          0, 0, sizeAfterRotation!.width, sizeAfterRotation!.height);

      if (scaleImage > 1 &&
          {89, 90, 91, 269, 270, 271}.contains(normalizedAngle)) {
        double newPainterRectHeight = ((sizeAfterRotation!.width * scaleImage))
            .clamp(sizeAfterRotation!.width, containerRenderBox.size.height);

        double newPainterRectWidth = ((sizeAfterRotation!.height * scaleImage))
            .clamp(sizeAfterRotation!.height, containerRenderBox.size.width);

        double newTop = newPainterRectHeight > containerRenderBox.size.width
            ? (containerRenderBox.size.width - newPainterRectHeight) / 2
            : 0;

        painterRect =
            Rect.fromLTWH(newTop, 0, newPainterRectHeight, newPainterRectWidth);
      } else if (scaleImage > 1 &&
          {0, 1, 180, 179, 181, 359, 360, 361}.contains(normalizedAngle)) {
        double newPainterRectHeight = ((sizeAfterRotation!.height * scaleImage))
            .clamp(sizeAfterRotation!.height, containerRenderBox.size.height);

        double newPainterRectWidth = ((sizeAfterRotation!.width * scaleImage))
            .clamp(sizeAfterRotation!.width, containerRenderBox.size.width);

        painterRect =
            Rect.fromLTWH(0, 0, newPainterRectWidth, newPainterRectHeight);
      }

      double scaleX = sizeAfterRotation!.width / imageRect!.height;
      double scaleY = sizeAfterRotation!.height / imageRect!.width;
      double scale = min(scaleX, scaleY);

      if ({0, 1, 180, 179, 181, 359, 360, 361}.contains(normalizedAngle)) {
        scaleX = imageRect!.width / sizeAfterRotation!.height;
        scaleY = imageRect!.height / sizeAfterRotation!.width;
        scale = max(scaleX, scaleY);
      }

      cropRect = Rect.fromLTWH(cropRect!.left * scale, cropRect!.top * scale,
          cropRect!.width * scale, cropRect!.height * scale);
    });
  }

  void handlePanStart(DragStartDetails details) {
    if ((details.localPosition - cropRect!.topCenter).distance <=
        cropRect!.height * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.top;
      });
    } else if ((details.localPosition - cropRect!.bottomCenter).distance <=
        cropRect!.height * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.bottom;
      });
    } else if ((details.localPosition - cropRect!.centerLeft).distance <=
        cropRect!.width * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.left;
      });
    } else if ((details.localPosition - cropRect!.centerRight).distance <=
        cropRect!.width * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.right;
      });
    } else if ((details.localPosition - cropRect!.topLeft).distance <=
        cropRect!.width * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.topLeft;
      });
    } else if ((details.localPosition - cropRect!.topRight).distance <=
        cropRect!.width * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.topRight;
      });
    } else if ((details.localPosition - cropRect!.bottomLeft).distance <=
        cropRect!.height * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.bottomLeft;
      });
    } else if ((details.localPosition - cropRect!.bottomRight).distance <=
        cropRect!.height * 0.1) {
      setState(() {
        selectedHandle = SelectedHandle.bottomRight;
      });
    } else if ((details.localPosition - cropRect!.center).distance <=
            cropRect!.width * 0.6 ||
        (details.localPosition - cropRect!.center).distance <=
            cropRect!.width * 0.6) {
      setState(() {
        selectedHandle = SelectedHandle.center;
      });
    }
  }

  void handlePanEnd(DragEndDetails details) {
    final RenderBox containerRenderBox =
        containerKey.currentContext?.findRenderObject() as RenderBox;

    double ratioX = (sizeBeforeRotation!.width) / cropRect!.width;
    double ratioY = (sizeBeforeRotation!.height) / cropRect!.height;
    double maxRatio = max(ratioX, ratioY);
    double minRatio = min(ratioX, ratioY);

    if (maxRatio >= (scaleImage + 0.5) &&
        selectedHandle != SelectedHandle.center &&
        selectedHandle != SelectedHandle.none) {
      setState(() {
        scaleImage = minRatio;

        if ({90, 91, 89, 270, 271, 269}.contains(normalizedAngle)) {
          double newPainterRectHeight = ((sizeBeforeRotation!.width *
                  scaleImage))
              .clamp(sizeBeforeRotation!.width, containerRenderBox.size.height);

          double newPainterRectWidth = ((sizeBeforeRotation!.height *
                  scaleImage))
              .clamp(sizeBeforeRotation!.height, containerRenderBox.size.width);

          double newTop = newPainterRectHeight > containerRenderBox.size.width
              ? (containerRenderBox.size.width - newPainterRectHeight) / 2
              : 0;

          painterRect = Rect.fromLTWH(
              newTop, 0, newPainterRectHeight, newPainterRectWidth);
        } else {
          double newPainterRectHeight =
              ((sizeBeforeRotation!.height * scaleImage)).clamp(
                  sizeBeforeRotation!.height, containerRenderBox.size.height);

          double newPainterRectWidth = ((sizeBeforeRotation!.width *
                  scaleImage))
              .clamp(sizeBeforeRotation!.width, containerRenderBox.size.width);

          double cropRatioX = (newPainterRectWidth) / painterRect!.width;
          double cropRatioY = (newPainterRectHeight) / painterRect!.height;
          double cropMaxRatio = max(cropRatioX, cropRatioY);

          double cropLeft = cropRect!.left - imageRect!.left;
          double cropTop = cropRect!.top - imageRect!.top;
          double cropRight = cropRect!.right - imageRect!.left;
          double cropBottom = cropRect!.bottom - imageRect!.top;

          double cropWidth = cropRect!.width;
          double cropHeight = cropRect!.height;

          double relativeCropLeft = cropLeft / imageRect!.width;
          double relativeCropTop = cropTop / imageRect!.height;
          double relativeCropRight = cropRight / imageRect!.width;
          double relativeCropBottom = cropBottom / imageRect!.height;

          painterRect =
              Rect.fromLTWH(0, 0, newPainterRectWidth, newPainterRectHeight);

          cropRect = Rect.fromLTWH(
              (cropRect!.left * cropMaxRatio)
                  .clamp(painterRect!.left, painterRect!.right),
              (cropRect!.top * cropMaxRatio)
                  .clamp(painterRect!.top, painterRect!.bottom),
              (cropRect!.width * cropMaxRatio).clamp(48, painterRect!.width),
              (cropRect!.height * cropMaxRatio).clamp(48, painterRect!.height));
        }
      });
    } else if (maxRatio < (scaleImage - 0.5) &&
        selectedHandle != SelectedHandle.center &&
        selectedHandle != SelectedHandle.none) {
      setState(() {
        scaleImage = maxRatio;

        if ({90, 91, 89, 270, 271, 269}.contains(normalizedAngle)) {
          double newPainterRectHeight = ((sizeBeforeRotation!.width *
                  scaleImage))
              .clamp(sizeBeforeRotation!.width, containerRenderBox.size.height);

          double newPainterRectWidth = ((sizeBeforeRotation!.height *
                  scaleImage))
              .clamp(sizeBeforeRotation!.height, containerRenderBox.size.width);

          double newTop = newPainterRectHeight > containerRenderBox.size.width
              ? (containerRenderBox.size.width - newPainterRectHeight) / 2
              : 0;

          painterRect = Rect.fromLTWH(
              newTop, 0, newPainterRectHeight, newPainterRectWidth);
        } else {
          double newPainterRectHeight =
              ((sizeBeforeRotation!.height * scaleImage)).clamp(
                  sizeBeforeRotation!.height, containerRenderBox.size.height);

          double newPainterRectWidth = ((sizeBeforeRotation!.width *
                  scaleImage))
              .clamp(sizeBeforeRotation!.width, containerRenderBox.size.width);

          painterRect =
              Rect.fromLTWH(0, 0, newPainterRectWidth, newPainterRectHeight);
        }
      });
    }

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
        if ((cropRect!.bottom - newTop) <= 48) {
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
        if ((newBottom - cropRect!.top) <= 48) {
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

        if ((cropRect!.right - newLeft) <= 48) {
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

        if ((newRight - cropRect!.left) <= 48) {
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

        if ((cropRect!.right - newLeft) <= 48) {
          newLeft = cropRect!.left;
        }
        if ((cropRect!.bottom - newTop) <= 48) {
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

        if ((cropRect!.bottom - newTop) <= 48) {
          newTop = cropRect!.top;
        }
        if ((newRight - cropRect!.left) <= 48) {
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

        if ((cropRect!.right - newLeft) <= 48) {
          newLeft = cropRect!.left;
        }
        if ((newBottom - cropRect!.top) <= 48) {
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

        if ((newBottom - cropRect!.top) <= 48) {
          newBottom = cropRect!.bottom;
        }
        if ((newRight - cropRect!.left) <= 48) {
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

        if (scaleImage > 1) {}
      });
    }
  }

  Offset? endPanPosition;
  Offset? panDelta;

  void handlePanUpdate(DragUpdateDetails details) {
    endPanPosition = details.localPosition;
    panDelta = details.delta;

    double imageCopyRectLeft =
        -(((imageRect!.width * scaleImage) - (imageRect!.width)) / 2);

    double imageCopyRectRight =
        -imageCopyRectLeft + (imageRect!.width * scaleImage);

    double imageCopyRectTop =
        -(((imageRect!.height * scaleImage) - (imageRect!.height)) / 2);

    double imageCopyRectBottom =
        -imageCopyRectTop + (imageRect!.height * scaleImage);

    Rect imageCopyRect = Rect.fromLTWH(imageCopyRectLeft, imageCopyRectTop,
        imageRect!.width * scaleImage, imageRect!.height * scaleImage);

    print(cropRect);
    print(imageCopyRect);

    if (scaleImage > 1 &&
        (cropRect!.topLeft == painterRect!.topLeft ||
            cropRect!.topRight == painterRect!.topRight ||
            cropRect!.bottomLeft == painterRect!.bottomLeft ||
            cropRect!.bottomRight == painterRect!.bottomRight ||
            cropRect!.top == painterRect!.top ||
            cropRect!.right == painterRect!.right ||
            cropRect!.bottom == painterRect!.bottom ||
            cropRect!.left == painterRect!.left)) {
      setState(() {
        translateImage = Offset(
            (translateImage.dx + details.delta.dx)
                .clamp(imageCopyRect.left, imageCopyRect.right),
            (translateImage.dy + details.delta.dy)
                .clamp(imageCopyRect.top, imageCopyRect.bottom));
      });
    }
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
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateSizeAndPosition();
      _getImageIntrinsicDimensions();
    });

    super.initState();
  }

  final GlobalKey scaleKey = GlobalKey();

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
              child: Container(
                  decoration: BoxDecoration(),
                  alignment: Alignment.center,
                  width: width,
                  height: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(16),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: rotateAngle, end: rotateAngle),
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.rotate(
                        angle: value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              key: containerKey,
                            ),
                            imageRect != null
                                ? TweenAnimationBuilder(
                                    tween: Tween<double>(
                                        begin: scaleImage, end: scaleImage),
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        origin: translateImage,
                                        key: scaleKey,
                                        child: TweenAnimationBuilder(
                                            tween: Tween<double?>(
                                                begin: imageRect?.height,
                                                end: imageRect?.height),
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return Image.file(
                                                File(widget.imagePath),
                                                fit: BoxFit.scaleDown,
                                                key: imageKey,
                                                height: value,
                                              );
                                            }),
                                      );
                                    },
                                  )
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
                                    child: painterRect != null
                                        ? TweenAnimationBuilder(
                                            tween: RectTween(
                                                begin: painterRect,
                                                end: painterRect),
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeInOut,
                                            builder: (context, value, child) {
                                              return TweenAnimationBuilder(
                                                onEnd: () {
                                                  setState(() {
                                                    animateCropRect = false;
                                                  });
                                                },
                                                tween: RectTween(
                                                    begin: cropRect,
                                                    end: cropRect),
                                                duration:
                                                    Duration(milliseconds: 400),
                                                curve: Curves.easeInOut,
                                                builder: (context, cropvalue,
                                                    child) {
                                                  return CustomPaint(
                                                      size: Size(value!.width,
                                                          value.height),
                                                      painter: CropPainter(
                                                          selectedHandle ==
                                                                      SelectedHandle
                                                                          .none &&
                                                                  animateCropRect
                                                              ? cropvalue!
                                                              : cropRect!,
                                                          value));
                                                },
                                              );
                                            },
                                          )
                                        : CustomPaint(
                                            size: Size(painterRect!.width,
                                                painterRect!.height),
                                            painter: CropPainter(
                                                cropRect!, painterRect!),
                                          ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    },
                  ))),
          Container(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
