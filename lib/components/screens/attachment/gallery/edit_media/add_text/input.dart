import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  Map<String, Color> calculateTextBackgroundColor(
      Color color, int activeTextBackgroundStyle) {
    if (activeTextBackgroundStyle == 0) {
      return {"font": color, "background": Colors.transparent};
    } else if (activeTextBackgroundStyle == 1) {
      return {
        "font": color,
        "background":
            color.computeLuminance() < 0.5 ? Colors.white : Colors.black
      };
    } else if (activeTextBackgroundStyle == 2) {
      return {
        "background": color,
        "font": color.computeLuminance() < 0.5 ? Colors.white : Colors.black
      };
    } else {
      return {"font": color, "background": Colors.black.withOpacity(0.4)};
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited data = EditMediaInherited.of(context)!;
    return Expanded(
        child: TextField(
      cursorColor: palette.primary,
      maxLines: null,
      style: TextStyle(
          fontSize: theme.textTheme.displayLarge!.fontSize! * data.fontSize,
          background: data.activeTextBackgroundStyle != 0
              ? (Paint()
                ..color = calculateTextBackgroundColor(data.selectedColor,
                    data.activeTextBackgroundStyle)["background"]!
                ..style = PaintingStyle.stroke
                ..strokeJoin = StrokeJoin.round
                ..strokeWidth = 48)
              : null,
          color: data.activeTextBackgroundStyle != 0
              ? calculateTextBackgroundColor(
                  data.selectedColor, data.activeTextBackgroundStyle)["font"]
              : data.selectedColor,
          fontWeight: FontWeight.normal),
      textAlign: data.textAlign,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Add Text",
          hintStyle: TextStyle(
              fontSize: theme.textTheme.displayLarge!.fontSize! * data.fontSize,
              color: palette.background.withOpacity(0.4),
              fontWeight: FontWeight.normal)),
    ));
  }
}
