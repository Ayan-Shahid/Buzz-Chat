import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class StickerTabBar extends StatefulWidget {
  const StickerTabBar({Key? key}) : super(key: key);

  @override
  _StickerTabBarState createState() => _StickerTabBarState();
}

class _StickerTabBarState extends State<StickerTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedTab = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        selectedTab = tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    return Container(
      decoration: ShapeDecoration(
          shape: StadiumBorder(), color: palette.background.withOpacity(0.2)),
      child: TabBar(
          indicatorWeight: 0.0,
          controller: tabController,
          dividerHeight: 0.0,
          indicatorColor: palette.foreground,
          labelColor: palette.foreground,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: palette.background.withOpacity(0.4),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.only(
                  topRight:
                      selectedTab == 1 ? Radius.circular(24) : Radius.zero,
                  bottomRight:
                      selectedTab == 1 ? Radius.circular(24) : Radius.zero,
                  topLeft: selectedTab == 0 ? Radius.circular(24) : Radius.zero,
                  bottomLeft:
                      selectedTab == 0 ? Radius.circular(24) : Radius.zero)),
          tabAlignment: TabAlignment.center,
          tabs: [
            Tab(
              text: "Stickers",
            ),
            Tab(
              text: "Emoji",
            )
          ]),
    );
  }
}
