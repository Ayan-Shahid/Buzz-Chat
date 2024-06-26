import 'package:flutter/material.dart';

class Sticker extends StatefulWidget {
  final Widget image;

  Sticker({required this.image});

  @override
  _StickerState createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  Offset? position;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        print(details);
      },
      onVerticalDragDown: (details) {
        print(details);
      },
      onVerticalDragEnd: (details) {
        print(details);
      },
      onVerticalDragUpdate: (details) {
        print(details);
        setState(() {
          position = details.localPosition;
        });
      },
      child: Transform.translate(
        offset: position ?? Offset.zero,
        child: widget.image,
      ),
    );
  }
}
