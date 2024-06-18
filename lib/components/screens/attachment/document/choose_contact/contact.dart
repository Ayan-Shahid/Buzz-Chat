import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  final bool selected;
  final void Function() onPressed;
  const Contact({Key? key, required this.selected, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor:
                selected ? palette.primaryInverse : palette.background,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            shape: BeveledRectangleBorder(),
            foregroundColor: selected ? palette.primary : palette.foreground),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 48,
                height: 48,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? palette.inputFocusedHint
                        : palette.container),
                child: AnimatedScale(
                    duration: Duration(milliseconds: 100),
                    scale: selected ? 1 : 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: selected
                                  ? palette.primaryInverse
                                  : palette.background),
                          color: palette.primary,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.check_rounded,
                        color: palette.onPrimary,
                        size: 12,
                      ),
                    ))),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "HaMzA_kAzMi_",
                    style: TextStyle(
                        color: selected
                            ? palette.onPrimaryInverse
                            : palette.foreground,
                        fontWeight: FontWeight.w600,
                        fontSize: theme.textTheme.bodyLarge?.fontSize),
                  ),
                  Text(
                    "راہ چلتے کویٔ خواب ملا تھا۔✨",
                    style: TextStyle(
                        color: selected
                            ? palette.onPrimaryInverse.withOpacity(0.2)
                            : palette.containerVariant,
                        fontWeight: FontWeight.w600,
                        fontSize: theme.textTheme.labelSmall?.fontSize),
                  )
                ],
              ),
            ),
            const Spacer(),
            Text(
              "Mobile",
              style: TextStyle(
                  color: selected
                      ? palette.onPrimaryInverse.withOpacity(0.2)
                      : palette.containerVariant,
                  fontWeight: FontWeight.w700,
                  fontSize: theme.textTheme.labelSmall?.fontSize),
            )
          ],
        ));
  }
}
