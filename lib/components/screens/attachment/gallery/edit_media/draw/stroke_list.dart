import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum StrokeStyle { thin, medium, thick, blur }

final List<Map<String, dynamic>> strokeStyles = [
  {"icon": "assets/icons/Thin Stroke.svg", "stroke": StrokeStyle.thin},
  {"icon": "assets/icons/Medium Stroke.svg", "stroke": StrokeStyle.medium},
  {"icon": "assets/icons/Thick Stroke.svg", "stroke": StrokeStyle.thick},
  {"icon": "assets/icons/Blur Stroke.svg", "stroke": StrokeStyle.blur},
];

class StrokeList extends StatelessWidget {
  const StrokeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    EditMediaInherited? data = EditMediaInherited.of(context);
    return ListView.builder(
        itemCount: strokeStyles.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => IconButton(
            onPressed: () {
              data?.setActiveStrokeStyle(strokeStyles[index]["stroke"]);
            },
            style: IconButton.styleFrom(
                minimumSize: Size.zero,
                backgroundColor:
                    data?.activeStrokeStyle == strokeStyles[index]["stroke"]
                        ? palette.background
                        : palette.background.withOpacity(0.04)),
            icon: SvgPicture.asset(
              strokeStyles[index]["icon"],
              color: data?.activeStrokeStyle != StrokeStyle.blur
                  ? data?.activeStrokeStyle == strokeStyles[index]["stroke"]
                      ? palette.foreground
                      : palette.background
                  : null,
            )));
  }
}
