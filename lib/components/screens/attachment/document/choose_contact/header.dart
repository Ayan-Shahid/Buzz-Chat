import 'package:buzzchat/screens/attachment/document/choose_contact.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final int length;
  const Header({Key? key, required this.length}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return AppBar(
      foregroundColor: palette.foreground,
      shape: BeveledRectangleBorder(
        side: BorderSide(width: 0.6, color: palette.container),
      ),
      actions: [
        IconButton(
          onPressed: ChooseContactInherited.of(context)?.toggle,
          icon: Icon(Icons.search_rounded),
          color: palette.foreground,
        )
      ],
      backgroundColor: palette.background,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded)),
      centerTitle: false,
      title: Text(
        length == 0 ? "Select Contacts" : "$length Selected",
        style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            color: palette.foreground),
      ),
      flexibleSpace: Container(
        color: palette.background,
      ),
    );
  }
}
