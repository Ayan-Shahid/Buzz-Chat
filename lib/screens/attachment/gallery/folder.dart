import 'package:buzzchat/components/screens/attachment/gallery/folder/header.dart';
import 'package:buzzchat/components/screens/attachment/gallery/gallery/gallery_tab.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section({
    Key? key,
    required String title,
    Color headerColor = Colors.white,
    Color titleColor = Colors.black,
    Color itemColor = Colors.black,
    required List<BuzzChatGalleyItem> items,
  }) : super(
          key: key,
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
                child: ColoredBox(
              color: headerColor,
              child: Container(
                color: headerColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Text(
                  title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: titleColor),
                ),
              ),
            )),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemCount: items.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: itemColor,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(items[index].url))),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditMedia()));
                    },
                  ),
                ),
              ),
            ),
          ],
        );
}

class Folder extends StatefulWidget {
  final BuzzChatGalleryFolder item;
  const Folder({Key? key, required this.item}) : super(key: key);

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: palette.background,
      appBar: Header(
        title: widget.item.name,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            Section(
              title: 'Recent',
              headerColor: palette.background,
              titleColor: palette.foreground,
              itemColor: palette.container,
              items: widget.item.items,
            ),
            Section(
                title: 'Last Month',
                headerColor: palette.background,
                titleColor: palette.foreground,
                itemColor: palette.container,
                items: widget.item.items),
          ],
        ),
      ),
    );
  }
}
