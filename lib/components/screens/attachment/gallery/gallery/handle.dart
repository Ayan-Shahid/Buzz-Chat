import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Handle extends StatelessWidget {
  const Handle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Container(
      width: 56,
      height: 6,
      decoration: ShapeDecoration(
          color: palette.containerVariant, shape: const StadiumBorder()),
    );
  }
}
