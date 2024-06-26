import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/font_list.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/shared/color_list.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited? data = EditMediaInherited.of(context);

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          data?.changeTextColor == true
              ? TextButton(
                  onPressed: data?.toggleChangeTextColor,
                  style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      backgroundColor: palette.background.withOpacity(0.04),
                      foregroundColor: palette.background,
                      shape: const CircleBorder()),
                  child: Text(
                    "Aa",
                    style: data?.selectedFont,
                  ),
                )
              : IconButton(
                  onPressed: data?.toggleChangeTextColor,
                  icon: const Icon(Icons.palette_rounded),
                  color: palette.background,
                  style: IconButton.styleFrom(
                      backgroundColor: palette.background.withOpacity(0.04)),
                ),
          const SizedBox(
            width: 8,
          ),
          Container(
            height: 40,
            width: 2,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: palette.background.withOpacity(0.4)),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Container(
                  height: 40,
                  child: data?.changeTextColor == true
                      ? ColorList(
                          onColorChanged: (color) =>
                              data?.setSelectedColor(color),
                        )
                      : FontList()))
        ],
      ),
    );
  }
}
