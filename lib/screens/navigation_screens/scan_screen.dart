import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import "package:flutter_tflite/flutter_tflite.dart";

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  CameraImage? cameraImage;
  
  CameraController? cameraController;
  String output = '';
  bool isScanning = false;

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
    if (mounted) {
      setState(() {
        cameraController!.startImageStream((imageStream) {
          if (isScanning) {
            cameraImage = imageStream;
            runModel();
          }
        });
      });
    }
  }

  Future<void> runModel() async {
    if (cameraImage != null) {
      final predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );

      if (predictions != null && predictions.isNotEmpty) {
        final labelCounts = <String, int>{};

        for (final prediction in predictions) {
          final label = prediction['label'] as String;
          final text = label.replaceAll(RegExp(r'[0-9]'), '');
          labelCounts[text] = (labelCounts[text] ?? 0) + 1;
        }

        String mostFrequentLabel = '';
        int maxCount = 0;

        labelCounts.forEach((label, count) {
          if (count > maxCount) {
            maxCount = count;
            mostFrequentLabel = label;
          }
        });

        setState(() {
          output = mostFrequentLabel.trim();
        });
      } else {
        setState(() {
          output = '';
        });
      }
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
      backgroundColor: Colors.black, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isScanning = !isScanning;
                  if (!isScanning) {
                    output = '';
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
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
                  if (isScanning)
                    CircularProgressIndicator(), // Show loading indicator while scanning
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              isScanning ? 'Scanning...' : output,
              style: TextStyle(fontSize: 30, color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
