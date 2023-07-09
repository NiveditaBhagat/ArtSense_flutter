import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/controller/prediction_descriptions.dart';
import 'package:flutter_art_sense/widgets/button.dart';

class ResultScreen extends StatelessWidget {
  final File? image;
  final String predictions;

  ResultScreen({required this.image, required this.predictions});

  @override
  Widget build(BuildContext context) {
     final String description = predictionDescriptions[predictions] ?? 'No description available';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.file(
                image!,
                height: 300,
                width: 500,
              ),
              SizedBox(height: 20),
              if (predictions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    predictions,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              MyButton(
            onPressed: (){},
            text: 'Save',
          ),
            ],
          ),
          
        ),
      ),
    );
  }
}