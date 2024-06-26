import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/content_sticker_list.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/shape_sticker_list.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Expanded(
        child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Content Stickers",
            style: TextStyle(
                color: palette.containerVariant, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          ContentStickerList(),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Shapes",
            style: TextStyle(
                color: palette.containerVariant, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          ShapeStickerList()
        ],
      ),
    ));
  }
}
