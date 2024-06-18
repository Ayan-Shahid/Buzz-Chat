import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return AppBar(
      backgroundColor: palette.background,
      centerTitle: false,
      title: Text(
        "1st Sessional Examination Schedule Spring 2024 Version Final as on 20-02-2024.xlsx",
        style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.w500,
            color: palette.foreground),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded)),
      flexibleSpace: Container(
        color: palette.background,
      ),
    );
  }
}
