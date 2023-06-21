import 'package:flutter/material.dart';
import 'package:flutter_art_sense/controller/carousel_api.dart';
import 'package:flutter_art_sense/model/carousel_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_art_sense/screens/artists_detail.dart';
import 'package:flutter_art_sense/screens/popular_paintings.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CarouselImage> images = [];
  List<Artists> mostViewedArtists = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
     fetchArtists();
  }

  Future<void> fetchImages() async {
    try {
      final List<CarouselImage> fetchedImages = await CarouselApi.fetchImages();
      fetchedImages.removeWhere((image) => image.image == null || image.image.isEmpty);
      setState(() {
        images = fetchedImages;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> fetchArtists() async {
  try {
    final List<Artists> fetchedArtists = await ArtistsController.fetchArtists();
    setState(() {
      mostViewedArtists = fetchedArtists;
    });
  } catch (error) {
    print(error.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
      
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 220,
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                  ),
                  items: images.map((image) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: image.image != null && image.image.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(image.image),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            image.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
           
       
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PopularPaintingScreen()));
                },
                child: Container(
                  height: 200,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/image5.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
              
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'Most Viewed Paintings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Most Popular Artists',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            Container(
               height: 135,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: mostViewedArtists.length,
                 itemBuilder: (BuildContext context, int index) {
                  final artist = mostViewedArtists[index];
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: GestureDetector(
                      onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistDetail(
                                artistImage: artist.ArtistImage,
                                artistName: artist.ArtistName,
                                wikiUrl: artist.WikiUrl,
                                )));       
                          },
                    child: Stack(
                      children: [
                        Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(15),
                         image: DecorationImage(
                         image: NetworkImage(artist.ArtistImage),
                          fit: BoxFit.cover,
              ),
            ),

          ),
                     
                        Positioned(
                          bottom: 0,
                          left: 6,
                          child: Text(
                            
                              artist.ArtistName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  
                      ],
                    ),
        ),
      );
    },
  ),
),
      SizedBox(height: 11,),
                    
            ],
          ),
        ),
      ),
    );
  }
}
