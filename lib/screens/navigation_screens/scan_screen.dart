import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_tflite/flutter_tflite.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({Key? key}) : super(key: key);

  @override
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  String _output = '';

  @override
  void initState() {
    super.initState();
    initializeCamera();
    loadModel();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final rearCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      rearCamera,
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();

    if (mounted) {
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    // Check for any errors or perform additional setup if required
  }

  Future<void> runModel(File imageFile) async {
    if (imageFile != null) {
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
      img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

      Uint8List imageBytes = imageToByteListUint8(resizedImage);

      var recognitions = await Tflite.runModelOnBinary(
        binary: imageBytes,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
      );

      String output = '';

      for (var recognition in recognitions!) {
        int index = recognition['index'];
        String label = recognition['label'];
        double confidence = recognition['confidence'];
        output += "Index: $index, Label: $label, Confidence: $confidence\n";
      }

      setState(() {
        _output = output;
      });
    }
  }

  Uint8List imageToByteListUint8(img.Image image) {
    var convertedBytes = Uint8List(602112);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < 224; i++) {
      for (var j = 0; j < 224; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              color: Colors.black54,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      XFile imageFile = await _cameraController.takePicture();
                      File file = File(imageFile.path);
                      runModel(file);
                    },
                    child: Icon(Icons.camera),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    _output,
                    style: TextStyle(color: Colors.black),
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
