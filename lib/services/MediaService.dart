import 'package:flutter/services.dart';

class MediaItem {
  final String name;
  final String category;
  final String type;
  final String path;
  final int size;
  final String file;
  final DateTime dateAdded;

  MediaItem({
    required this.name,
    required this.category,
    required this.type,
    required this.path,
    required this.size,
    required this.file,
    required this.dateAdded,
  });

  factory MediaItem.fromMap(Map<String, dynamic> map) {
    return MediaItem(
      name: map['name'],
      category: map['category'],
      type: map['type'],
      path: map['path'],
      size: map['size'],
      file: map['file'],
      dateAdded: DateTime.fromMillisecondsSinceEpoch(map['dateAdded']),
    );
  }
}

class MediaService {
  static const platform = MethodChannel('com.example.photo_gallery/media');

  Future<List<MediaItem>> getMediaItems() async {
    try {
      final List<dynamic> mediaItems =
          await platform.invokeMethod('getMediaItems');

      return mediaItems.map((item) {
        return MediaItem.fromMap(Map<String, dynamic>.from(item));
      }).toList();
    } catch (e) {
      throw e;
    }
  }
}
