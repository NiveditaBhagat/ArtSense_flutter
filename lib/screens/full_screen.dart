import 'package:flutter/material.dart';
import 'package:flutter_art_sense/save_images_box.dart';
import 'package:flutter_art_sense/screens/navigation_screens/collection_screen.dart';
import 'package:flutter_art_sense/widgets/button.dart';


class FullScreen extends StatelessWidget {
  final String imageUrl;
  final String title;


  FullScreen({Key? key, required this.imageUrl, required this.title, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 30,
            child: Container(
              width: 200,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay-Bold',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: MyButton(
              onPressed: () {
                final savedImagesBox = SavedImagesBox();
            savedImagesBox.addImage(imageUrl);
                 Navigator.push(context,MaterialPageRoute(
                builder: (context) => Collectionscreen(),),);
              },
              text: 'Save',
              color: Color(0xFFFF4B26),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
