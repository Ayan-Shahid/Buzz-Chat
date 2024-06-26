import 'package:buzzchat/screens/attachment/gallery/folder.dart';
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
    FolderInherited? data = FolderInherited.of(context);
    return AppBar(
      leadingWidth: data?.selectMultiple == false ? 32 : null,
      backgroundColor: palette.container,
      shape:
          Border(bottom: BorderSide(color: palette.inverseContainer, width: 1)),
      centerTitle: false,
      actions: [
        Visibility(
            visible: data?.selectMultiple == false,
            child: IconButton(
                onPressed: () {
                  data?.toggleSelectMultiple();
                },
                icon: Icon(Icons.check_box_outlined),
                color: palette.foreground))
      ],
      title: Text(
        data?.selectMultiple == false
            ? title
            : data?.selected.isEmpty == true
                ? "Tap photo to select"
                : "${data?.selected.length} Selected",
        style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.w500,
            color: palette.foreground),
      ),
      leading: IconButton(
          onPressed: () {
            data?.selectMultiple == true
                ? data?.toggleSelectMultiple()
                : Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded)),
      flexibleSpace: Container(
        color: palette.container,
      ),
    );
  }
}
