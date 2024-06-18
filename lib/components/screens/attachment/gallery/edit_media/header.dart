import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: palette.background,
      foregroundColor: palette.foreground,
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.hd_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.crop_rotate_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.note_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.text_fields)),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined))
      ],
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.close_rounded),
        color: palette.foreground,
      ),
    );
  }
}
