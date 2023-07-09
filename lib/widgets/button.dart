import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final  Function onPressed;
final String text;
  const MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () => onPressed(),
                
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 45),
                primary: Colors.white,
                shape: StadiumBorder(),
              ),
            );
  }
}


// Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));