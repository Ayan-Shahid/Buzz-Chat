import 'dart:io';

import 'package:buzzchat/main.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class AttachmentButton extends StatefulWidget {
  const AttachmentButton({Key? key}) : super(key: key);

  @override
  _AttachmentButtonState createState() => _AttachmentButtonState();
}

class _AttachmentButtonState extends State<AttachmentButton> {
  final OverlayPortalController controller = OverlayPortalController();
  final LayerLink link = LayerLink();
  List<Map<String, dynamic>> actions(BuzzChatPaletteExtension palette) {
    return [
      {
        "icon": Icons.feed_rounded,
        "name": "Document",
        "background": palette.error,
        "foreground": palette.onError
      },
      {
        "icon": Icons.camera_alt_rounded,
        "name": "Camera",
        "background": palette.primary,
        "foreground": palette.onPrimary
      },
      {
        "icon": Icons.image,
        "name": "Gallery",
        "background": palette.background,
        "foreground": palette.foreground
      },
      {
        "icon": Icons.headphones_rounded,
        "name": "Audio",
        "background": palette.error,
        "foreground": palette.onError
      },
      {
        "icon": Icons.location_on_rounded,
        "name": "Location",
        "background": palette.primary,
        "foreground": palette.onPrimary
      },
      {
        "icon": Icons.person,
        "name": "Contact",
        "background": palette.background,
        "foreground": palette.foreground
      },
      {
        "icon": Icons.poll_rounded,
        "name": "Poll",
        "background": palette.error,
        "foreground": palette.onError
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    ThemeData theme = context.theme;
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return Positioned(
            bottom: 88,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              margin: EdgeInsets.all(16),
              width: context.screen.width - 16 - 16,
              decoration: BoxDecoration(
                  color: palette.container,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: SizedBox(
                    child: GridView.builder(
                  itemCount: actions(palette).length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          style: IconButton.styleFrom(
                              padding: EdgeInsets.all(16),
                              backgroundColor: actions(palette)[index]
                                  ["background"],
                              foregroundColor: actions(palette)[index]
                                  ["foreground"]),
                          onPressed: () {
                            print("object");
                          },
                          icon: Icon(
                            actions(palette)[index]["icon"],
                            size: theme.textTheme.titleLarge?.fontSize,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(actions(palette)[index]["name"])
                    ],
                  ),
                )),
              ),
            ));
      },
      child: IconButton(
          style: IconButton.styleFrom(
              padding: EdgeInsets.all(16),
              backgroundColor: palette.container,
              foregroundColor: palette.foreground),
          onPressed: () => controller.toggle(),
          icon: Icon(
            Icons.attachment_rounded,
            size: theme.textTheme.titleLarge?.fontSize,
          )),
    );
  }
}


// SizedBox(
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         clipBehavior: Clip.none,
//         children: [
//           ...actions.asMap().entries.map((element) {
//             return AnimatedPositioned(
//                 curve: Curves.fastEaseInToSlowEaseOut,
//                 duration: Duration(milliseconds: 200),
//                 bottom: open ? 72 * (element.key.toDouble() + 1) : 0,
//                 child: IconButton(
//                     style: IconButton.styleFrom(
//                         padding: EdgeInsets.all(16),
//                         backgroundColor: palette.container,
//                         foregroundColor: palette.foreground),
//                     onPressed: () {
//                       print("object");
//                     },
//                     icon: Icon(
//                       element.value,
//                       size: theme.textTheme.titleLarge?.fontSize,
//                     )));
//           }),
//           IconButton(
//               style: IconButton.styleFrom(
//                   padding: EdgeInsets.all(16),
//                   backgroundColor: palette.container,
//                   foregroundColor: palette.foreground),
//               onPressed: toggle,
//               icon: Icon(
//                 Icons.attachment_rounded,
//                 size: theme.textTheme.titleLarge?.fontSize,
//               ))
//         ],
//       ),
//     )