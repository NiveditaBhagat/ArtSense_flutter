import 'package:flutter/material.dart';
import 'package:flutter_art_sense/widgets/button.dart';

class FullScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
    final Function(String) onSave;
  FullScreen({super.key, required this.imageUrl, required this.title, required this.onSave });

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
                  )
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
                 ),
                 ),
             ),
           ),
           Positioned(
            bottom: 30,
            right: 10,
            child: MyButton(
              onPressed: (){
                onSave(imageUrl);
              }, 
              text: 'Save',
              )),
        ],
       
      ),
    );
  }
}