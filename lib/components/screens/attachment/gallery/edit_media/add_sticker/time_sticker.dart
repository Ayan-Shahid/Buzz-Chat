import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSticker extends StatefulWidget {
  const TimeSticker({Key? key}) : super(key: key);

  @override
  _TimeStickerState createState() => _TimeStickerState();
}

class _TimeStickerState extends State<TimeSticker> {
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: ShapeDecoration(
          shape: StadiumBorder(
              side: BorderSide(color: palette.background, width: 1)),
          color: palette.foreground.withOpacity(0.4)),
      child: Text(
        DateFormat("h:mm a").format(DateTime.now()),
        style: TextStyle(
            color: palette.background,
            fontWeight: FontWeight.w600,
            fontSize: theme.textTheme.labelSmall?.fontSize),
      ),
    );
  }
}
