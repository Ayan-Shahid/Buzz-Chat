import 'dart:io';

import 'package:buzzchat/screens/attachment/gallery/folder.dart';
import 'package:buzzchat/services/MediaService.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BuzzChatGalleyItem {
  final String url;
  final DateTime date;

  const BuzzChatGalleyItem({required this.url, required this.date});
}

class BuzzChatGalleryFolder {
  final String name;
  int numItems;
  String thumbNail;
  final List<BuzzChatGalleyItem> items;

  BuzzChatGalleryFolder(
      {required this.name,
      required this.items,
      this.numItems = 0,
      this.thumbNail = ""}) {
    thumbNail = items[0].url;
    numItems = items.length;
  }
}

class GalleryTab extends StatefulWidget {
  const GalleryTab({Key? key}) : super(key: key);

  @override
  _GalleryTabState createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  final MediaService _mediaService = MediaService();
  late Future<List<MediaItem>> _mediaItems;
  late Future<List<BuzzChatGalleryFolder>> _galleryFolders;

  late Future<List<BuzzChatGalleryFolder>> _folders;
  Future<List<BuzzChatGalleryFolder>> getGalleryFolders() async {
    List<MediaItem> media = await MediaService().getMediaItems();

    List<String> mediaFolderNames = [];

    for (MediaItem element in media) {
      mediaFolderNames.add(element.category);
    }
    mediaFolderNames = mediaFolderNames.toSet().toList();

    List<BuzzChatGalleryFolder> galleryFolders = [];

    for (String element in mediaFolderNames) {
      List<BuzzChatGalleyItem> items = [];
      for (MediaItem galleryItem in media) {
        if (galleryItem.category == element) {
          print(galleryItem.path);
          items.add(BuzzChatGalleyItem(
              url: galleryItem.path, date: galleryItem.dateAdded));
        }
      }
      galleryFolders.add(BuzzChatGalleryFolder(name: element, items: items));
    }
    return galleryFolders;
  }

  Future<List<BuzzChatGalleryFolder>> _listFolders() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref().listAll();

    List<BuzzChatGalleryFolder> folderNames = [];
    for (var prefix in result.prefixes) {
      List<BuzzChatGalleyItem> items = [];
      ListResult result = await prefix.listAll();
      for (Reference element in result.items) {
        String url = await element.getDownloadURL();
        FullMetadata metadata = await element.getMetadata();
        DateTime date = metadata.timeCreated ?? DateTime.now();
        items.add(BuzzChatGalleyItem(url: url, date: date));
      }
      folderNames
          .add(BuzzChatGalleryFolder(name: prefix.fullPath, items: items));
    }

    return folderNames;
  }

  @override
  void initState() {
    super.initState();
    _galleryFolders = getGalleryFolders();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<List<BuzzChatGalleryFolder>>(
        future: _galleryFolders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 10,
              child: Center(
                  child: CircularProgressIndicator(
                color: palette.primary,
                backgroundColor: palette.inverseContainer,
              )),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Text("No Data");
          }
          return GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 4, crossAxisSpacing: 4, crossAxisCount: 2),
              itemBuilder: (context, index) => Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Folder(
                                  item: snapshot.data![index],
                                )));
                      },
                      splashColor: palette.background,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                            color: palette.inverseContainer,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                    File(snapshot.data![index].thumbNail)))),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                palette.foreground,
                                palette.foreground.withOpacity(0)
                              ])),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.folder_outlined,
                                color: palette.background,
                                size: theme.textTheme.bodyLarge?.fontSize,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                snapshot.data![index].name,
                                style: TextStyle(
                                    color: palette.background,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        theme.textTheme.labelSmall?.fontSize),
                              ),
                              const Spacer(),
                              Text("${snapshot.data![index].numItems}",
                                  style: TextStyle(
                                      color: palette.background,
                                      fontWeight: FontWeight.w500,
                                      fontSize: theme
                                          .textTheme.labelSmall?.fontSize)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        });
  }
}
