
import 'package:flutter/material.dart';
import 'package:flutter_art_sense/screens/navigation_screens/collection_screen.dart';
import 'package:flutter_art_sense/screens/navigation_screens/home_screen.dart';
import 'package:flutter_art_sense/screens/navigation_screens/scan_screen.dart';
import 'package:flutter_art_sense/screens/navigation_screens/search_screen.dart';
import 'package:flutter_art_sense/screens/navigation_screens/setting_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var pageIndex=[
     HomeScreen(),
    SearchScreen(),
    ScannerScreen(),
    Collectionscreen(),
    SettingScreen(),

  ];

  int pageIdx=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
    
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, 
          unselectedItemColor:Colors.grey[500],
         backgroundColor: Colors.grey[900],
           selectedItemColor: Colors.white,
               onTap: (value) {
          setState(() {
            pageIdx=value;
          });
              },
              currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '',
             ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
      body: Center(
         child: pageIndex[pageIdx], 
      ),
    );
  }
}
