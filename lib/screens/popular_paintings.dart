import 'package:flutter/material.dart';
import 'package:flutter_art_sense/controller/controller.dart';
import 'package:flutter_art_sense/model/model.dart';
import 'package:flutter_art_sense/screens/full_screen.dart';
import 'package:flutter_art_sense/screens/navigation_screens/collection_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PopularPaintingScreen extends StatefulWidget {
  const PopularPaintingScreen({Key? key}) : super(key: key);

  @override
  _PopularPaintingScreenState createState() => _PopularPaintingScreenState();
}

class _PopularPaintingScreenState extends State<PopularPaintingScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  List<PopularImage> paintings = [];
  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    fetchPaintings();
  }

  Future<void> fetchPaintings() async {
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final api = PaintingAPI();
      final List<PopularImage> fetchedPaintings = await api.fetchPaintings();
      setState(() {
        paintings.addAll(fetchedPaintings);
      });
    } catch (error) {
      print(error.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  //   void saveImageToCollection(String imageUrl) {
  //   // Call this function to save the image URL to the collection
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Collectionscreen(
      
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 90) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        if (index >= paintings.length) {
                          // Reached the end, load more paintings
                          fetchPaintings();
                          return Container();
                        }

                        final painting = paintings[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(
                                  imageUrl: painting.popular_paintings,
                                  title: painting. popular_title,
                                  
                                  )));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: painting.popular_paintings,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey,
                                  ),
                                  placeholder: (context, url) => AspectRatio(
                                    aspectRatio: (800 + index) / ((index % 2 + 1) * 970), // Set a fixed aspect ratio value here
                                    child: Container(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.more_horiz,
                                size: 20,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: paintings.length + 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 