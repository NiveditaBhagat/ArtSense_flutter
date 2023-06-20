import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ArtistDetail extends StatelessWidget {
   final String artistImage;
   final String artistName;
  const ArtistDetail({super.key ,required this.artistImage, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Artists", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        elevation: 0,
      ),
      body: Column(
            children: [
              Container(
               margin: EdgeInsets.only(left: 17, right: 17, bottom: 20, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image:CachedNetworkImageProvider(artistImage),
                    fit: BoxFit.fill,
                     colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                    ),
                ),
                height: 250,
              ),
              Text(
                artistName,
                
              ),
            ],
      ),
   
    );
  }
}