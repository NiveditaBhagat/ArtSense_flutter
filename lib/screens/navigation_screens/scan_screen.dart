import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/scanned_image_screen.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraController? cameraController;
  String output = '';
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  void loadCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController!.initialize();
  }

  Future<void> runModel() async {
    if (!isProcessing) {
      isProcessing = true;

      // Capture an image from the camera
      final XFile capturedImage = await cameraController!.takePicture();

      // Display the captured image on a new screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScannedImageScreen(
            imagePath: capturedImage.path,
            imageLabel: output.trim(),
          ),
        ),
      );

      isProcessing = false;
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          if (!isProcessing && output.isNotEmpty) {
            runModel();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: !cameraController!.value.isInitialized
                      ? Container()
                      : AspectRatio(
                          aspectRatio: cameraController!.value.aspectRatio,
                          child: CameraPreview(cameraController!),
                        ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                output,
                style: TextStyle(fontSize: 30, color: Colors.purple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
