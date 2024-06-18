import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_list.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_matrix.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/header.dart';
import 'package:buzzchat/components/screens/attachment/gallery/edit_media/input.dart';
import 'package:buzzchat/components/screens/attachment/shared/footer.dart';
import 'package:buzzchat/theme/theme.dart';
import 'package:flutter/material.dart';

class EditMedia extends StatefulWidget {
  const EditMedia({Key? key}) : super(key: key);

  @override
  _EditMediaState createState() => _EditMediaState();
}

class _EditMediaState extends State<EditMedia> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.theme;
    BuzzChatPaletteExtension palette = context.theme.palette;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Header(),
      backgroundColor: palette.background,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            child: Image.network(
                "https://images.unsplash.com/photo-1718703357732-8c7aef2b6b51?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          )),
          // Input(),
          FilterList()
          // Footer()
        ],
      )),
    );
  }
}
