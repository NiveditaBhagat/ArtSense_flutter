import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_art_sense/save_images_box.dart';

class Collectionscreen extends StatefulWidget {
  @override
  _CollectionscreenState createState() => _CollectionscreenState();
}

class _CollectionscreenState extends State<Collectionscreen> {
  final SavedImagesBox _savedImagesBox = SavedImagesBox();
  List<dynamic> savedImages = [];

  @override
  void initState() {
    super.initState();
    getSavedImages();
  }

  void getSavedImages() async {
    final images = await _savedImagesBox.getImages();
    setState(() {
      savedImages = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Collections',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay-Bold',
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.2
        ),
        itemBuilder: (context, index) {
          final item = savedImages[index];
          if (item is String) {
            if (item.startsWith('http')) {
              return CachedNetworkImage(
                imageUrl: item,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Color(0xFFFF4B26),
                  strokeWidth: 0.6,
                  ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            } else {
              return Image.file(
                File(item),
                fit: BoxFit.cover,
              );
            }
          } else {
            return Container(); // Placeholder widget if the item is of unknown type
          }
        },
        itemCount: savedImages.length,
      ),
    );
  }
}
