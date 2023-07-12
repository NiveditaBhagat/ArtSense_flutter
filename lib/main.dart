import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_art_sense/screens/onboarding_page.dart';

List<CameraDescription>? cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage(),
    );
  }
}
  
