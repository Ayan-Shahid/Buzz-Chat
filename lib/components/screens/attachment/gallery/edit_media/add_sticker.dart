import 'dart:ui';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/content.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/footer.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/header.dart';

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class AddSticker extends StatefulWidget {
  const AddSticker({Key? key}) : super(key: key);

  @override
  _AddStickerState createState() => _AddStickerState();
}

class _AddStickerState extends State<AddSticker> {
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    // ThemeData theme = context.theme;
    // EditMediaInherited data = EditMediaInherited.of(context)!;

    return Stack(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 24),
          duration: Duration(milliseconds: 400),
          builder: (context, value, child) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
            child: Container(
              color: palette.background.withOpacity(0),
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 88,
            ),
            Header(),
            const SizedBox(
              height: 24,
            ),
            Content(),
            Footer()
          ],
        )
      ],
    );
  }
}
