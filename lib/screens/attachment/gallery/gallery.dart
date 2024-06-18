import 'package:buzzchat/components/screens/attachment/gallery/gallery/gallery_tab_bar.dart';
import 'package:buzzchat/components/screens/attachment/gallery/gallery/handle.dart';
import 'package:buzzchat/components/screens/attachment/gallery/gallery/header.dart';

import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      decoration: BoxDecoration(
          color: palette.container,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Handle(),
          const SizedBox(
            height: 16,
          ),
          Header(),
          GalleryTabBar()
        ],
      ),
    );
  }
}
