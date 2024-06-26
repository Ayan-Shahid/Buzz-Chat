import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class FontList extends StatelessWidget {
  const FontList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited? data = EditMediaInherited.of(context);
    return ListView.builder(
        itemCount: fonts.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => TextButton(
              onPressed: () {
                data?.setSelectedFont(index);
              },
              style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  backgroundColor: data?.selectedFont == fonts[index]
                      ? palette.background
                      : palette.background.withOpacity(0.04),
                  foregroundColor: data?.selectedFont == fonts[index]
                      ? palette.foreground
                      : palette.background,
                  shape: const CircleBorder()),
              child: Text(
                "Aa",
                style: fonts[index],
              ),
            ));
  }
}
