import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      color: palette.background,
      child: TextField(
        cursorColor: palette.primary,
        style: MaterialStateTextStyle.resolveWith((states) =>
            states.contains(MaterialState.focused)
                ? TextStyle(color: palette.onPrimaryInverse)
                : TextStyle(color: palette.foreground)),
        decoration: InputDecoration(
            hintStyle: MaterialStateTextStyle.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? TextStyle(color: palette.inputFocusedHint)
                    : TextStyle(color: palette.containerVariant)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: palette.primary),
                borderRadius: BorderRadius.circular(24)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(24)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? palette.primaryInputFocusedBackground
                    : palette.container),
            filled: true,
            hintText: "Add a caption..."),
      ),
    );
  }
}
