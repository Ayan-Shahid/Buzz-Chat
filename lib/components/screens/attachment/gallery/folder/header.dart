import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const Header({Key? key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return AppBar(
      backgroundColor: palette.container,
      shape:
          Border(bottom: BorderSide(color: palette.inverseContainer, width: 1)),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.check_box_outlined),
            color: palette.foreground)
      ],
      title: Text(
        title,
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
        color: palette.container,
      ),
    );
  }
}
