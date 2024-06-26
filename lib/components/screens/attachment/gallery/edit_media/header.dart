import 'package:buzzchat/components/screens/attachment/gallery/edit_media/transform_image.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final String imagePath;
  const Header({Key? key, required this.imagePath}) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool stickerTabAnimationComplete = false;
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    EditMediaInherited? data = EditMediaInherited.of(context);
    return Container(
      width: width,
      height: 80,
      padding: EdgeInsets.only(left: 8, right: 8, top: 32),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              child: IconButton(
                onPressed: () {
                  data?.setActiveTab(0);
                },
                icon: Icon(data?.activeTab == 2
                    ? Icons.arrow_back_rounded
                    : Icons.close_rounded),
                color: palette.background,
                style: IconButton.styleFrom(
                    backgroundColor: palette.background.withOpacity(0.04)),
              )),
          AnimatedPositioned(
            right: data?.activeTab == 2 ? 0 : 48,
            curve: Curves.elasticOut,
            duration: Duration(milliseconds: 1800),
            child: IconButton(
              color: palette.background,
              onPressed: () {
                data?.setActiveTab(3);
              },
              icon: Icon(Icons.title_rounded),
              style: IconButton.styleFrom(
                  backgroundColor: palette.background.withOpacity(0.04)),
            ),
          ),
          AnimatedPositioned(
            right: data?.activeTab == 2 ? 0 : 146,
            curve: Curves.elasticOut,
            duration: Duration(milliseconds: 1800),
            child: IconButton(
              color: palette.background,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TransformImage(
                          imagePath: widget.imagePath,
                        )));
              },
              icon: Icon(Icons.crop_rotate_rounded),
              style: IconButton.styleFrom(
                  backgroundColor: palette.background.withOpacity(0.04)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1800),
            curve: Curves.elasticOut,
            right: data?.activeTab == 2 ? 0 : 196,
            child: IconButton(
              color: palette.background,
              onPressed: () {},
              icon: Icon(Icons.hd_outlined),
              style: IconButton.styleFrom(
                  backgroundColor: palette.background.withOpacity(0.04)),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.elasticOut,
            right: data?.activeTab == 2 ? 0 : 0,
            duration: Duration(milliseconds: 1800),
            child: IconButton(
              color: palette.background,
              onPressed: () {
                data?.setActiveTab(4);
              },
              icon: Icon(Icons.edit_outlined),
              style: IconButton.styleFrom(
                  backgroundColor: palette.background.withOpacity(0.04)),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.elasticOut,
            right: data?.activeTab == 2 ? 0 : 96,
            duration: Duration(milliseconds: 1800),
            child: IconButton(
              color:
                  data?.activeTab == 2 ? palette.onPrimary : palette.background,
              onPressed: () {
                data?.setActiveTab(2);
              },
              icon: SvgPicture.asset("assets/icons/Sticker.svg"),
              style: IconButton.styleFrom(
                  backgroundColor: data?.activeTab == 2
                      ? palette.primary
                      : palette.background.withOpacity(0.04)),
            ),
          ),
        ],
      ),
    );
  }
}
