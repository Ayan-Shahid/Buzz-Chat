import 'package:buzzchat/components/screens/attachment/document/overview/content.dart';
import 'package:buzzchat/components/screens/attachment/shared/footer.dart';
import 'package:buzzchat/components/screens/attachment/document/overview/header.dart';
import 'package:buzzchat/components/screens/attachment/document/overview/input.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: const Header(),
      body: const SafeArea(
          child: Column(
        children: [Content(), Input(), Footer()],
      )),
    );
  }
}
