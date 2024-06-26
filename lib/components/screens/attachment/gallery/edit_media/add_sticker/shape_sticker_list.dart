import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShapeStickerList extends StatelessWidget {
  const ShapeStickerList({Key? key}) : super(key: key);
  static const List<String> shapes = [
    "Arrow",
    "Circle Bubble",
    "Cloud",
    "Ellipse",
    "Rectangle",
    "Square Bubble"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 24, crossAxisSpacing: 24, crossAxisCount: 4),
        itemCount: shapes.length,
        itemBuilder: (context, index) {
          return SvgPicture.asset(
            'assets/stickers/shapes/${shapes[index]}.svg',
            width: 40,
            height: 40,
            fit: BoxFit.scaleDown,
          );
        });
  }
}
