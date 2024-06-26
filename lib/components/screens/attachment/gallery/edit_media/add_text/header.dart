import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited? data = EditMediaInherited.of(context);
    EditMediaInherited? editMediaData = EditMediaInherited.of(context);

    return Container(
      width: width,
      height: 80,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 64,
          ),
          Row(
            children: [
              IconButton(
                onPressed: data?.toggleTextAlign ?? () {},
                icon: Icon(data?.textAlign == TextAlign.center
                    ? Icons.format_align_center_rounded
                    : data?.textAlign == TextAlign.left
                        ? Icons.format_align_left_rounded
                        : Icons.format_align_right_rounded),
                color: palette.background,
                style: IconButton.styleFrom(
                    backgroundColor: palette.background.withOpacity(0.04)),
              ),
              const SizedBox(
                width: 0,
              ),
              IconButton(
                onPressed: data?.toggleActiveBackgroundStyle ?? () {},
                icon: Icon(data?.activeTextBackgroundStyle == 0
                    ? Icons.font_download_outlined
                    : Icons.font_download_rounded),
                color: palette.background,
                style: IconButton.styleFrom(
                    backgroundColor: palette.background.withOpacity(0.04)),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              editMediaData?.setActiveTab(0);
            },
            child: const Text("Done"),
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                minimumSize: Size.zero,
                backgroundColor: palette.background.withOpacity(0.04),
                foregroundColor: palette.background,
                shape: const StadiumBorder()),
          )
        ],
      ),
    );
  }
}
