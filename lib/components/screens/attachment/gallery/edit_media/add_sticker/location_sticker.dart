import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationSticker extends StatefulWidget {
  const LocationSticker({Key? key}) : super(key: key);

  @override
  _LocationStickerState createState() => _LocationStickerState();
}

class _LocationStickerState extends State<LocationSticker> {
  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      width: 100,
      decoration: BoxDecoration(
          color: palette.background, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(
            Icons.location_on_sharp,
            color: palette.primary,
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: palette.containerVariant,
            ),
            height: 8,
          )),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
