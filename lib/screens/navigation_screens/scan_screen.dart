import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/result_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ArtScanner extends StatefulWidget {
  @override
  _ArtScannerState createState() => _ArtScannerState();
}

class _ArtScannerState extends State<ArtScanner> {
  File? _image;
  List<dynamic>? _output;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite', // Replace with your model's path
      labels: 'assets/labels.txt', // Replace with your labels' path
    );
  }

  Future<void> runInference(File? image) async {
    if (image == null) return;

    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2, // Number of desired classification results
      threshold: 0.5, // Minimum confidence threshold for classification
    );

    setState(() {
      _output = output;
    });

    if (_output != null && _output!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            image: _image!,
            prediction: _output![0]['label']),
        ),
      );
    }
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(
          image: _image!,
          prediction: _output![0]['label'],
          )),
      );

      runInference(_image!);
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Scanner'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null ? Image.file(_image!) : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
