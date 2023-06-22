import 'dart:io';

import 'package:flutter/material.dart';

class ScannedImageScreen extends StatelessWidget {
  final String imagePath;
  final String imageLabel;

  const ScannedImageScreen({
    required this.imagePath,
    required this.imageLabel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanned Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(imagePath)),
            SizedBox(height: 24),
            Text(
              'Image Label: $imageLabel',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
