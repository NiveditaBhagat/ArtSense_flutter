import 'dart:convert';
import 'package:flutter_art_sense/model/carousel_image.dart';
import 'package:http/http.dart' as http;

class CarouselApi {
  static const String apiUrl =
      //'http://www.wikiart.org/en/App/Painting/MostViewedPaintings?offset=0&quantity=100&limit=100&randomSeed=123&json=2';
'http://www.wikiart.org/en/App/Painting/MostViewedPaintings?randomSeed=123&json=2&inPublicDomain={true}';
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

class PaintingAPI {
  static const String apiUrl =
      'https://www.wikiart.org/en/popular-paintings?json=1&page=';

  int currentPage = 1;
  bool isLoading = false;

  Future<List<PopularImage>> fetchPaintings() async {
    if (isLoading) {
      return []; // Return empty list if already loading to avoid duplicate requests
    }

    isLoading = true;

    final String url = apiUrl + currentPage.toString();

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final paintings = jsonResponse
            .map((paintingData) => PopularImage.fromJson(paintingData))
            .toList();

        currentPage++; // Increment the current page for the next request
        isLoading = false; // Reset the loading flag

        return paintings;
      } else {
        throw Exception('Failed to fetch paintings');
      }
    } catch (error) {
      isLoading = false; // Reset the loading flag on error
      throw error;
    }
  }
}

class ArtistsController {
  static const String apiUrl = 'https://www.wikiart.org/en/app/api/popularartists?json=1';

  static Future<List<Artists>> fetchArtists() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<Artists> artists = [];

        for (final artistData in jsonResponse) {
          artists.add(Artists.fromJson(artistData));
        }

        return artists;
      } else {
        throw Exception('Failed to fetch artists');
      }
    } catch (error) {
      throw error;
    }
  }
}




