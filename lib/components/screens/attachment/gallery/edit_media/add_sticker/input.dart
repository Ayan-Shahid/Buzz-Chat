import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Expanded(
        child: TextField(
      cursorColor: palette.primary,
      style: TextStyle(color: palette.background),
      decoration: InputDecoration(
          hintText: "Search",
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          hintStyle: TextStyle(color: palette.containerVariant),
          fillColor: palette.container,
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ));
  }
}
