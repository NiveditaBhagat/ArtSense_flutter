import 'dart:io';

import 'package:hive/hive.dart';

class SavedImagesBox {
  static const String _boxName = 'saved_images';

  Future<Box<List<String>>> _openBox() async {
    return await Hive.openBox<List<String>>(_boxName);
  }

  Future<void> addImage(dynamic image) async {
    final box = await _openBox();
    final images = box.get(_boxName, defaultValue: []) ?? [];

    if (image is String) {
      images.add(image);
    } else if (image is File) {
      images.add(image.path);
    }

    await box.put(_boxName, images);
  }

  Future<List<String>> getImages() async {
    final box = await _openBox();
    return box.get(_boxName, defaultValue: []) ?? [];
  }
}
