import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/input.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/add_sticker/sticker_tab_bar.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool showTextField = false;
  bool animateTextField = false;
  bool showTabBar = true;

  void toggleShowTextField() {
    if (animateTextField == false) {
      setState(() {
        animateTextField = true;
        showTabBar = false;
      });
      Future.delayed(Duration(milliseconds: 240), () {
        setState(() {
          showTextField = true;
        });
      });
    } else {
      setState(() {
        showTextField = false;
      });
      Future.delayed(Duration(milliseconds: 240), () {
        setState(() {
          animateTextField = false;
        });
      });
      Future.delayed(Duration(milliseconds: 400), () {
        setState(() {
          showTabBar = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            clipBehavior: Clip.antiAlias,
            duration: Duration(milliseconds: 200),
            width: animateTextField ? width - 16 : 48,
            decoration: ShapeDecoration(
              shape: StadiumBorder(),
              color: animateTextField ? palette.background : Colors.transparent,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: toggleShowTextField,
                  icon: Icon(Icons.search_rounded),
                  color:
                      showTextField ? palette.foreground : palette.background,
                  style: IconButton.styleFrom(
                      backgroundColor: showTextField
                          ? palette.background
                          : palette.background.withOpacity(0.08)),
                ),
                Visibility(visible: showTextField, child: Input())
              ],
            ),
          ),
          Visibility(
            visible: showTabBar,
            child: StickerTabBar(),
          ),
          Visibility(
              visible: showTabBar,
              child: const SizedBox(
                width: 32,
              ))
        ],
      ),
    );
  }
}
