import 'dart:convert';
import 'package:flutter_art_sense/model/carousel_image.dart';
import 'package:http/http.dart' as http;

class CarouselApi {
  static const String apiUrl =
      'http://www.wikiart.org/en/App/Painting/MostViewedPaintings?offset=0&quantity=100&limit=100&randomSeed=123&json=2';

  static Future<List<CarouselImage>> fetchImages() async {
    final currentDay = DateTime.now().day;
    final jsonVersion = 'v$currentDay';

    final response = await http.get(Uri.parse('$apiUrl?json=$jsonVersion'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((imageData) => CarouselImage.fromJson(imageData))
          .toList();
    } else {
      throw Exception('Failed to fetch carousel images');
    }
  }
}
