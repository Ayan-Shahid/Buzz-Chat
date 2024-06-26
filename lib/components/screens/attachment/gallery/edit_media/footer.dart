import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_list.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/input.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:buzzchat/components/screens/attachment/shared/footer.dart'
    as contact_list_footer;

class Footer extends StatelessWidget {
  final String imagePath;
  const Footer({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    EditMediaInherited data = EditMediaInherited.of(context)!;
    return Stack(
      children: [
        AnimatedOpacity(
          opacity: data.filterListPosition,
          duration: Duration.zero,
          child: Column(
            children: [
              SizedBox(
                width: width,
                child: Input(),
              ),
              contact_list_footer.Footer(
                tagColor: BuzzChatPalette.grayscale.grayscale500,
                textStyle:
                    TextStyle(color: BuzzChatPalette.grayscale.grayscale1000),
                backgroundColor:
                    BuzzChatPalette.grayscale.grayscale500.withOpacity(0.2),
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: AnimatedSlide(
              offset: Offset(0, data.filterListPosition),
              duration: Duration(milliseconds: 0),
              child: FilterList(
                imagePath: imagePath,
              ),
            ))
      ],
    );
  }
}
