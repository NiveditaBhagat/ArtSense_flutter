
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/home_page.dart';
import 'package:flutter_art_sense/widgets/button.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/image4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
              Positioned(
            top: 80,
            left: 20,
            child: Text(
              'ArtSense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay-ExtraBold',
              ),
            ),
          ),
             Positioned(
            top: 150,
            left: 20,
            child: Text(
              'Discover the world of art',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'PlayfairDisplay-Bold',
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 120,
            child: MyButton(
              onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));},        
              text: 'Get Started',
              color: Colors.white,
              textColor: Colors.black,
              ),
          ),
        ],
      ),
    );
  }
}
