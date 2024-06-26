import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;

    return Container(
      color: palette.foreground.withOpacity(0.4),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.foreground.withOpacity(0.4),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.access_time_rounded,
              color: palette.background,
              size: theme.textTheme.headlineLarge?.fontSize,
            ),
          )
        ],
      ),
    );
  }
}
