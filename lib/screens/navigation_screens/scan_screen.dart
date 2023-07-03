import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:flutter_art_sense/screens/result_screen.dart';

class ArtScanner extends StatefulWidget {
  @override
  _ArtScannerState createState() => _ArtScannerState();
}

class _ArtScannerState extends State<ArtScanner> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  File? _image;
  String output = '';

  @override
  void initState() {
    super.initState();
    setupCamera();
    loadModel();
  }

  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    print("Available cameras: $_cameras");
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(_cameras![0], ResolutionPreset.medium);
      await _controller!.initialize();

      setState(() {}); // Add this line to trigger a rebuild after camera initialization
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
  }
Future<void> runInference(File? image) async {
  if (image == null) return;

  final predictions = await Tflite.runModelOnImage(
    path: image.path,
    numResults: 4,
    threshold: 0.05,
  );

  String mostFrequentLabel = '';
  int maxCount = 0;

  if (predictions != null && predictions.isNotEmpty) {
    final labelCounts = <String, int>{};
    for (final prediction in predictions) {
      final label = prediction['label'] as String;
      final text = label.replaceAll(RegExp(r'[0-13]'), '');
      labelCounts[text] = (labelCounts[text] ?? 0) + 1;
    }

    labelCounts.forEach((label, count) {
      if (count > maxCount) {
        maxCount = count;
        mostFrequentLabel = label;
      }
    });
  }

  setState(() {
    output = mostFrequentLabel.trim();
  });

  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultScreen(
        image: image,
        predictions: output,
      ),
    ),
  );
}

  Future<void> pickImage() async {
    try {
      final XFile? capturedImage = await _controller?.takePicture();

      if (capturedImage != null) {
        setState(() {
          _image = File(capturedImage.path);
        });

        runInference(_image!);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameras == null || _cameras!.isEmpty || !_controller!.value.isInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black, // Opacity of the outside container
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent, // Transparent background for the middle container
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: CameraPreview(_controller!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: pickImage,
                    child: Icon(Icons.camera_alt,color: Colors.grey,),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Scan Artwork',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
