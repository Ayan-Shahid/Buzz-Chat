import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // AddTextInherited? data = AddTextInherited.of(context);
    EditMediaInherited? editMediaData = EditMediaInherited.of(context);

    return Container(
      width: width,
      height: 80,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Transform.rotate(
              angle: 1.6,
              child: Icon(Icons.u_turn_left_rounded),
            ),
            color: palette.background,
            style: IconButton.styleFrom(
                backgroundColor: palette.background.withOpacity(0.04)),
          ),
          const SizedBox(
            width: 4,
          ),
          TextButton(
            onPressed: () {
              editMediaData?.setActiveTab(0);
            },
            child: const Text("Done"),
            style: TextButton.styleFrom(
                backgroundColor: palette.background.withOpacity(0.04),
                foregroundColor: palette.background,
                shape: const StadiumBorder()),
          )
        ],
      ),
    );
  }
}
