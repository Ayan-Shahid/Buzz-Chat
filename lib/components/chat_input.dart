import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return Expanded(
      child: TextField(
        cursorColor: palette.primary,
        style: TextStyle(fontSize: theme.textTheme.bodySmall?.fontSize),
        decoration: InputDecoration(
            prefixIconColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return palette.primary;
              } else {
                return palette.primaryInputHint;
              }
            }),
            suffixIconColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return palette.primary;
              } else {
                return palette.primaryInputHint;
              }
            }),
            prefixIcon: Container(
              padding: EdgeInsets.all(2),
              child: IconButton(
                  style: IconButton.styleFrom(),
                  onPressed: () {},
                  icon: Icon(Icons.emoji_emotions_outlined)),
            ),
            suffixIcon: Container(
              padding: EdgeInsets.all(2),
              child: IconButton(
                  style: IconButton.styleFrom(),
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            filled: true,
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return palette.primaryInputFocusedBackground;
              } else {
                return palette.primaryInputBackground;
              }
            }),
            hintStyle: MaterialStateTextStyle.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return TextStyle(color: palette.inputFocusedHint);
              } else {
                return TextStyle(color: palette.primaryInputHint);
              }
            }),
            hintText: "Message...",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: palette.primary)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
