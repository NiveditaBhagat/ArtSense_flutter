import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

void main() {
  runApp(ArtistDetailApp());
}

class ArtistDetailApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artist Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArtistDetail(
        artistImage:
            'https://example.com/artist_image.jpg', // Replace with actual image URL
        artistName: 'Artist Name', // Replace with actual artist name
        wikiUrl: 'https://example.com/artist_wiki', // Replace with actual Wikipedia URL
      ),
    );
  }
}

class ArtistDetail extends StatefulWidget {
  final String artistImage;
  final String artistName;
  final String wikiUrl;

  const ArtistDetail({
    Key? key,
    required this.artistImage,
    required this.artistName,
    required this.wikiUrl,
  }) : super(key: key);

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  String article = '';

  @override
  void initState() {
    super.initState();
    fetchArticle();
  }

  void fetchArticle() async {
    try {
      String fetchedArticle = await fetchArticleContent(widget.wikiUrl);
      setState(() {
        article = fetchedArticle;
      });
    } catch (e) {
      print('Error fetching article: $e');
    }
  }

  Future<String> fetchArticleContent(String wikiUrl) async {
  try {
    var response = await http.get(Uri.parse(wikiUrl));

    if (response.statusCode == 200) {
      var document = parse(response.body);
      var content = document.querySelector('.mw-parser-output');

      if (content != null) {
        // Find the desired section using its class or ID
        var desiredSection = content.querySelector('.desired-section');
        if (desiredSection != null) {
          removeStyling(desiredSection);
          return desiredSection.text;
        } else {
          throw Exception('Failed to find the desired section');
        }
      } else {
        throw Exception('Failed to parse article content');
      }
    } else {
      throw Exception('Failed to fetch article content');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}


  void removeStyling(dom.Element element) {
    element.nodes.forEach((node) {
      if (node is dom.Element) {
        if (node.attributes.containsKey('style')) {
          node.attributes.remove('style');
        }
        removeStyling(node);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(article);
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              child: Text(
                "Artists",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.artistImage),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.artistName,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            article,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
