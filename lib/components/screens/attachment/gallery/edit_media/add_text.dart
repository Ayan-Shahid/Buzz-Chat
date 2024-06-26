import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/input.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_text/text_size_slider.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';

import 'package:flutter/material.dart';

class AddText extends StatelessWidget {
  const AddText({super.key});
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    // BuzzChatPaletteExtension palette = context.theme.palette;
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited data = EditMediaInherited.of(context)!;
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 0.6),
      duration: Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: BuzzChatPalette.grayscale.grayscale100.withOpacity(value),
          alignment: Alignment.center,
          child: Row(
            children: [
              Input(),
              const SizedBox(
                width: 24,
              ),
              TextSizeSlider(
                onSliderUpdated: data.setFontSize,
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        );
      },
    );
  }
}
