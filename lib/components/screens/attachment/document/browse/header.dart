import 'package:buzzchat/screens/attachment/document/browse.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    BrowseInherited? data = BrowseInherited.of(context);

    return AppBar(
      flexibleSpace: Container(
        color: palette.background,
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: palette.foreground,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: palette.foreground,
          ),
          onPressed: data?.toggleInput,
        ),
        PopupMenuButton(
            color: palette.background,
            icon: Icon(
              Icons.filter_list_rounded,
              color: palette.foreground,
            ),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sort by name"),
                        const SizedBox(
                          width: 6,
                        ),
                        Radio(
                          value: 2,
                          groupValue: 2,
                          onChanged: (value) {},
                          activeColor: palette.primary,
                        )
                      ],
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sort by date"),
                        Radio(
                            value: false, groupValue: 0, onChanged: (value) {})
                      ],
                    ),
                    value: 0,
                  ),
                ]),
      ],
      title: Text(
        "Documents",
        style: TextStyle(
            fontSize: theme.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.w500,
            color: palette.foreground),
      ),
    );
  }
}
