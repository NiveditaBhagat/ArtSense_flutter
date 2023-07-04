import 'package:flutter/material.dart';
import 'package:flutter_art_sense/controller/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Search_Controller _searchController = Search_Controller();
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchTextController = TextEditingController();

  void _searchImages(String keyword) async {
    try {
      List<Map<String, dynamic>> results = await _searchController.searchImages(keyword);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Artworks', style: TextStyle(fontWeight: FontWeight.w600),),
        backgroundColor: Colors.black,
      ),
     backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
              
                style: TextStyle(color: Colors.white),
                controller: _searchTextController,
                onChanged: (value) {
                  _searchImages(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  hintText: 'Enter keyword',
                  hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.white,),
                     enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide.none,
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                       focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                     ),
                    
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: GridView.builder(
                itemCount: _searchResults.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 0.7
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> result = _searchResults[index];
                  final String image = result['image'] ?? '';
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Container(
                                        color: Colors.grey,
                                      ),
                      ),
                    ),
                  );
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
