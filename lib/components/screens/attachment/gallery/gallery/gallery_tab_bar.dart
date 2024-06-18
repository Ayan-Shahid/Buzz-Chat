import 'package:buzzchat/components/screens/attachment/gallery/gallery/gallery_tab.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class GalleryTabBar extends StatelessWidget {
  const GalleryTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuzzChatPaletteExtension palette = context.theme.palette;

    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                indicatorColor: palette.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: palette.primary,
                unselectedLabelColor: palette.containerVariant,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    text: "Recents",
                  ),
                  Tab(
                    text: "Gallery",
                  )
                ]),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              height: height - 200,
              child: TabBarView(children: [Text(""), GalleryTab()]),
            )
          ],
        ));
  }
}
