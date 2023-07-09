import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Collectionscreen extends StatefulWidget {


  const Collectionscreen({required this.savedImages});

  @override
  _CollectionscreenState createState() => _CollectionscreenState();
}

class _CollectionscreenState extends State<Collectionscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collections',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: widget.savedImages[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        },
        itemCount: widget.savedImages.length,
      ),
    );
  }
}
