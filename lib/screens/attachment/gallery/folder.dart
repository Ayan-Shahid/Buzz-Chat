import 'dart:io';

import 'package:buzzchat/components/screens/attachment/gallery/folder/header.dart';
import 'package:buzzchat/components/screens/attachment/gallery/gallery/gallery_tab.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends MultiSliver {
  Section(
      {Key? key,
      required String title,
      required BuzzChatPaletteExtension palette,
      required List<BuzzChatGalleyItem> items,
      required bool selectMultiple,
      void Function(int index)? onTap,
      required List<BuzzChatGalleyItem> selected})
      : super(
          key: key,
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
                child: ColoredBox(
              color: palette.background,
              child: Container(
                color: palette.background,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: palette.foreground),
                ),
              ),
            )),
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemCount: items.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: palette.container,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(File(items[index].url)))),
                child: Stack(
                  children: [
                    Visibility(
                        visible: selected.contains(items[index]),
                        child: Positioned.fill(
                            child: ColoredBox(
                                color: palette.background.withOpacity(0.4)))),
                    Visibility(
                      visible: selected.contains(items[index]),
                      child: Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            height: 28,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: palette.primary),
                            child: Text(
                              "${selected.indexOf(items[index])}",
                              style: TextStyle(
                                  color: palette.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          selectMultiple
                              ? onTap!(index)
                              : Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditMedia(
                                        imagePath: items[index].url,
                                      )));
                        },
                      ),
                    ),
                  ],
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
  bool selectMultiple = false;

  List<BuzzChatGalleyItem> selected = [];

  void selectMultipleTap(int index) {
    setState(() {
      selected.contains(widget.item.items[index])
          ? selected.remove(widget.item.items[index])
          : selected.add(widget.item.items[index]);
    });
  }

  void toggleSelectMultiple() {
    setState(() {
      selectMultiple = !selectMultiple;
      selected = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;

    return FolderInherited(
        selected: selected,
        selectMultiple: selectMultiple,
        toggleSelectMultiple: toggleSelectMultiple,
        child: Scaffold(
          backgroundColor: palette.background,
          appBar: Header(
            title: widget.item.name,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: CustomScrollView(
                  slivers: [
                    Section(
                      title: 'Recent',
                      selectMultiple: selectMultiple,
                      palette: palette,
                      items: widget.item.items,
                      selected: selected,
                      onTap: selectMultipleTap,
                    ),
                    Section(
                        title: 'Last Month',
                        selectMultiple: selectMultiple,
                        selected: selected,
                        onTap: selectMultipleTap,
                        palette: palette,
                        items: widget.item.items),
                  ],
                )),
                Visibility(
                    visible: selected.isNotEmpty,
                    child: Container(
                      color: palette.container,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      height: 72,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: selected.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                        margin: EdgeInsets.only(
                                            left: index == 0 ? 0 : 12),
                                        width: 64,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: palette.inverseContainer,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    selected[index].url))),
                                      ))),
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.check_rounded),
                            style: IconButton.styleFrom(
                                padding: EdgeInsets.all(16),
                                backgroundColor: palette.primary,
                                foregroundColor: palette.onPrimary),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}

class FolderInherited extends InheritedWidget {
  final bool selectMultiple;
  final void Function() toggleSelectMultiple;
  final List<BuzzChatGalleyItem> selected;
  const FolderInherited(
      {Key? key,
      required Widget child,
      required this.selectMultiple,
      required this.selected,
      required this.toggleSelectMultiple})
      : super(key: key, child: child);

  static FolderInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FolderInherited>();
  }

  @override
  bool updateShouldNotify(FolderInherited oldWidget) {
    return oldWidget.selectMultiple != selectMultiple;
  }
}
