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
   String desiredSection = '';

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
          return extractDesiredSection(content);
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



String extractDesiredSection(dom.Element content) {
  var paragraphs = content.getElementsByTagName('p');
  var desiredSection = '';

  // Find the desired section based on specific criteria
  for (var i = 0; i < paragraphs.length; i++) {
    var paragraph = paragraphs[i];
    var paragraphText = paragraph.text.trim();

    // Adjust the conditions to match the criteria for the desired section
    if (paragraphText.isNotEmpty && paragraphText.length > 50) {
      desiredSection = paragraphText;
      break;
    }
  }

  return desiredSection;
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
                 
                  

              color: Colors.white
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                               article,
                              style: TextStyle(fontSize: 21, color: Colors.black),
                            ),
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
