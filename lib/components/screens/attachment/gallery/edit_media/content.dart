import 'dart:io';

import 'package:buzzchat/components/screens/attachment/gallery/edit_media/filter_matrix.dart';
import 'package:buzzchat/screens/attachment/gallery/edit_media.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String imagePath;
  const Content({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  Size? size;
  final GlobalKey imageKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print(imageKey.currentContext?.size);

      setState(() {
        size = imageKey.currentContext?.size;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditMediaInherited data = EditMediaInherited.of(context)!;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: FilterMatrix.filters[data.filter].name == "None"
          ? Image.file(
              File(widget.imagePath),
              fit: BoxFit.contain,
              key: imageKey,
            )
          : ColorFiltered(
              colorFilter:
                  ColorFilter.matrix(FilterMatrix.filters[data.filter].matrix),
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.contain,
                key: imageKey,
              ),
            ),
    );
  }
}
