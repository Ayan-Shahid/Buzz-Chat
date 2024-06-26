import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/clock_sticker.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/location_sticker.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/time_sticker.dart';
import 'package:flutter/material.dart';

class ContentStickerList extends StatelessWidget {
  const ContentStickerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [TimeSticker(), ClockSticker(), LocationSticker()],
    );
  }
}
