import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/footer.dart'
    as add_text_footer;
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/draw/footer.dart'
    as draw_footer;
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/draw/stroke_list.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/footer.dart'
    as edit_media_footer;

// import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/header.dart'
// as AddTextHeader;
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/content.dart';

import 'package:buzzchat/components/screens/attachment/gallery/edit_media/draw/header.dart'
    as draw_header;

import 'package:buzzchat/components/screens/attachment/gallery/edit_media/header.dart'
    as edit_media_header;
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/header.dart'
    as add_text_header;

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final List<TextStyle> fonts = [
  GoogleFonts.montserrat(),
  GoogleFonts.lora(),
  GoogleFonts.caveat(),
];

class EditMedia extends StatefulWidget {
  final String imagePath;
  const EditMedia({Key? key, required this.imagePath}) : super(key: key);

  @override
  _EditMediaState createState() => _EditMediaState();
}

class _EditMediaState extends State<EditMedia> {
  bool hasColorList = true;
  double filterListPosition = 1;
  double filterListAnimationSpeed = 200;
  double _handlePosition =
      100; // Initial handle position (corresponds to _sliderValue = 0.5)
  double _containerHeight = 140; // Height of the slider container
  void _updateSliderValue() {
    // Update _sliderValue based on the current handle position
    double range = 1.0; // Range of slider values (from 0.1 to 1.0)
    double proportion = (_handlePosition /
        _containerHeight); // Calculate proportion from handle position
    filterListPosition =
        0.0 + (proportion * range); // Adjust to the desired range
  }

  void updateSliderPosition() {}
  StrokeStyle activeStrokeStyle = StrokeStyle.thin;
  void toggleHasColorList() {
    setState(() {
      hasColorList = !hasColorList;
    });
  }

  void setActiveStrokeStyle(StrokeStyle style) {
    setState(() {
      activeStrokeStyle = style;
    });
  }

  int activeTab = 0;
  final List<Widget> headers = [
    const add_text_header.Header(),
    const draw_header.Header()
  ];

  late Widget currentHeader;
  late Widget currentFooter;
  int filter = 0;
  bool showFilter = false;
  void selectFilter(int index) {
    setState(() {
      filter = index;
    });
  }

  void setActiveTab(int index) {
    setState(() {
      activeTab = index;
    });
    if (activeTab == 2) {
      setState(() {
        currentHeader = edit_media_header.Header(imagePath: widget.imagePath);
        currentFooter = SizedBox();
      });
    } else if (activeTab == 3) {
      setState(() {
        currentHeader = headers[1];
        currentFooter = const add_text_footer.Footer();
      });
    } else if (activeTab == 4) {
      setState(() {
        currentHeader = headers[2];
        currentFooter = const draw_footer.Footer();
      });
    } else {
      setState(() {
        currentHeader = edit_media_header.Header(imagePath: widget.imagePath);
        currentFooter = edit_media_footer.Footer(
          imagePath: widget.imagePath,
        );
      });
    }
  }

  void toggleShowFilters() {
    setState(() {
      showFilter = !showFilter;
    });
  }

  int activeTextBackgroundStyle = 0;
  bool changeTextColor = true;

  double fontSize = 0.5;

  TextStyle selectedFont = GoogleFonts.montserrat();
  Color selectedColor = Colors.white;
  TextAlign textAlign = TextAlign.center;

  void toggleActiveBackgroundStyle() {
    if (activeTextBackgroundStyle == 3) {
      setState(() {
        activeTextBackgroundStyle = 0;
      });
    } else {
      setState(() {
        activeTextBackgroundStyle += 1;
      });
    }
  }

  void toggleTextAlign() {
    if (textAlign == TextAlign.center) {
      setState(() {
        textAlign = TextAlign.left;
      });
    } else if (textAlign == TextAlign.left) {
      setState(() {
        textAlign = TextAlign.right;
      });
    } else if (textAlign == TextAlign.right) {
      setState(() {
        textAlign = TextAlign.center;
      });
    }
  }

  void setSelectedFont(int index) {
    setState(() {
      selectedFont = fonts[index];
    });
  }

  void toggleChangeTextColor() {
    setState(() {
      changeTextColor = !changeTextColor;
    });
  }

  void setSelectedColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void setFontSize(double size) {
    setState(() {
      fontSize = size;
    });
  }

  @override
  void initState() {
    setState(() {
      currentFooter = edit_media_footer.Footer(imagePath: widget.imagePath);
      currentHeader = edit_media_header.Header(imagePath: widget.imagePath);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return EditMediaInherited(
        filterListPosition: filterListPosition,
        selectedColor: selectedColor,
        setFontSize: setFontSize,
        filterListAnimationSpeed: filterListAnimationSpeed,
        fontSize: fontSize,
        selectedFont: selectedFont,
        setSelectedColor: setSelectedColor,
        setSelectedFont: setSelectedFont,
        toggleChangeTextColor: toggleChangeTextColor,
        changeTextColor: changeTextColor,
        activeTextBackgroundStyle: activeTextBackgroundStyle,
        toggleActiveBackgroundStyle: toggleActiveBackgroundStyle,
        textAlign: textAlign,
        toggleTextAlign: toggleTextAlign,
        activeTab: activeTab,
        activeStrokeStyle: activeStrokeStyle,
        setActiveStrokeStyle: setActiveStrokeStyle,
        hasColorList: hasColorList,
        toggleHasColorList: toggleHasColorList,
        showFilter: showFilter,
        setActiveTab: setActiveTab,
        filter: filter,
        selectFilter: selectFilter,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeIn,
                child: currentHeader,
              )),
          backgroundColor: palette.foreground,
          body: Stack(
            children: [
              Positioned.fill(
                  child: Stack(
                children: [
                  AnimatedScale(
                    scale: 0.7 + 0.3 * (filterListPosition),
                    duration: const Duration(milliseconds: 0),
                    child: Content(
                      imagePath: widget.imagePath,
                    ),
                  ),
                  activeTab == 3
                      ? AddText()
                      : activeTab == 2
                          ? AddSticker()
                          : GestureDetector(
                              onVerticalDragEnd: (DragEndDetails details) {
                                // Calculate duration based on velocity
                                double velocityFactor =
                                    0.05; // Adjust for desired sensitivity
                                double duration = (200 /
                                    (details.primaryVelocity!.abs() *
                                        velocityFactor));

                                // Animate to the final position using AnimatedSlide
                                setState(() {
                                  filterListAnimationSpeed = duration;
                                });
                              },
                              onVerticalDragUpdate:
                                  (DragUpdateDetails details) {
                                // Update handle position based on vertical drag
                                setState(() {
                                  _handlePosition += details.primaryDelta!;

                                  if (_handlePosition < 0) {
                                    _handlePosition = 0;
                                  } else if (_handlePosition >
                                      _containerHeight) {
                                    _handlePosition = _containerHeight;
                                  }

                                  _updateSliderValue();
                                  // if (filterListPosition * 140 >= 40) {
                                  //   setState(() {
                                  //     filterListPosition = 1.0;
                                  //   }); // Snap to full top (1.0)
                                  // } else {
                                  //   setState(() {
                                  //     filterListPosition = 0.0; //
                                  //   });
                                  // }
                                });
                              },
                            ),
                ],
              )),
              Positioned(
                  bottom: 0,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: currentFooter,
                  ))
            ],
          ),
        ));
  }
}

class EditMediaInherited extends InheritedWidget {
  final int filter;
  final bool showFilter;
  final void Function(int index) selectFilter;
  final int activeTab;
  final void Function(int index) setActiveTab;
  final bool hasColorList;
  final void Function() toggleHasColorList;
  final StrokeStyle activeStrokeStyle;
  final void Function(StrokeStyle style) setActiveStrokeStyle;
  final TextAlign textAlign;
  final void Function() toggleTextAlign;
  final int activeTextBackgroundStyle;
  final void Function() toggleActiveBackgroundStyle;
  final bool changeTextColor;

  final TextStyle selectedFont;
  final Color selectedColor;
  final void Function(int index) setSelectedFont;

  final void Function(Color color) setSelectedColor;

  final void Function() toggleChangeTextColor;
  final double fontSize;

  final void Function(double size) setFontSize;
  final double filterListPosition;
  final double filterListAnimationSpeed;

  const EditMediaInherited(
      {Key? key,
      required this.filter,
      required this.filterListAnimationSpeed,
      required this.setFontSize,
      required this.filterListPosition,
      required this.hasColorList,
      required this.activeStrokeStyle,
      required this.setActiveStrokeStyle,
      required this.toggleHasColorList,
      required this.showFilter,
      required this.activeTab,
      required this.setActiveTab,
      required this.selectFilter,
      required this.textAlign,
      required this.fontSize,
      required this.selectedColor,
      required this.selectedFont,
      required this.changeTextColor,
      required this.activeTextBackgroundStyle,
      required this.toggleActiveBackgroundStyle,
      required this.setSelectedColor,
      required this.setSelectedFont,
      required this.toggleChangeTextColor,
      required this.toggleTextAlign,
      required Widget child})
      : super(key: key, child: child);

  static EditMediaInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<EditMediaInherited>();
  }

  @override
  bool updateShouldNotify(EditMediaInherited oldWidget) {
    return filter != oldWidget.filter ||
        oldWidget.activeTab != activeTab ||
        oldWidget.showFilter != showFilter ||
        oldWidget.hasColorList != hasColorList ||
        oldWidget.activeStrokeStyle != activeStrokeStyle ||
        oldWidget.textAlign != textAlign ||
        oldWidget.activeTextBackgroundStyle != activeTextBackgroundStyle ||
        oldWidget.changeTextColor != changeTextColor ||
        oldWidget.selectedColor != selectedColor ||
        oldWidget.selectedFont != selectedFont ||
        oldWidget.filterListPosition != filterListPosition ||
        oldWidget.filterListAnimationSpeed != filterListAnimationSpeed;
  }
}
