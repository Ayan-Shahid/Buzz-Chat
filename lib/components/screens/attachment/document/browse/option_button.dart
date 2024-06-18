import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;
  final Function()? onPressed;
  const OptionButton(
      {Key? key,
      required this.title,
      required this.label,
      required this.icon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            backgroundColor: palette.background,
            foregroundColor: palette.foreground,
            elevation: 0.0,
            shape: BeveledRectangleBorder()),
        onPressed: onPressed ?? () {},
        child: Row(
          children: [
            Icon(
              icon,
              color: palette.primary,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: palette.foreground,
                      fontSize: theme.textTheme.bodyLarge?.fontSize),
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: palette.containerVariant,
                      fontSize: theme.textTheme.bodySmall?.fontSize),
                ),
              ],
            )
          ],
        ));
  }
}
