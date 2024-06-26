import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetToImage extends StatefulWidget {
  final Widget child;

  WidgetToImage({required this.child});

  @override
  _WidgetToImageState createState() => _WidgetToImageState();
}

class _WidgetToImageState extends State<WidgetToImage> {
  GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _capturePng());
  }

  Future<void> _capturePng() async {
    await Future.delayed(Duration(milliseconds: 100));

    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      setState(() {
        _imageBytes = pngBytes;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: _imageBytes == null ? widget.child : Image.memory(_imageBytes!),
    );
  }
}
