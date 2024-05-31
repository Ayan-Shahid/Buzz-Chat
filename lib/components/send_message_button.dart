import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class SendMessageButton extends StatefulWidget {
  const SendMessageButton({Key? key}) : super(key: key);

  @override
  _SendMessageButtonState createState() => _SendMessageButtonState();
}

class _SendMessageButtonState extends State<SendMessageButton> {
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return IconButton(
        style: IconButton.styleFrom(
            padding: EdgeInsets.all(14),
            backgroundColor: palette.primary,
            foregroundColor: palette.onPrimary),
        onPressed: () {},
        icon: Icon(
          Icons.mic_rounded,
          size: 24,
        ));
  }
}
