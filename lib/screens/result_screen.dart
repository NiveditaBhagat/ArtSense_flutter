import 'dart:io';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final File? image;
  final String predictions;

  ResultScreen({required this.image, required this.predictions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          Image.file(image!),
          SizedBox(height: 20),
          Text('Predictions:'),
          SizedBox(height: 10),
          if (predictions != null)
            Column(
             children: [
              Text(predictions, style: TextStyle(color: Colors.black),),
             ],
            ),
        ],
      ),
    );
  }
}

