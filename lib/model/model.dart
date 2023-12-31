import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
class CarouselImage {
  final String title;
  final String image;

  CarouselImage({required this.title, required this.image});

  factory CarouselImage.fromJson(Map<String, dynamic> json) {
    return CarouselImage(
      title: json['title'],
      image: json['image'],
    );
  }
}

class PopularImage{
  final String popular_title;
  final String popular_paintings;

  PopularImage({required this.popular_paintings, required this.popular_title});

  factory PopularImage.fromJson(Map<String, dynamic> json){
    return PopularImage(
      popular_paintings: json['image'], 
      popular_title: json['title'],
      );
  }
}

class Artists{
  final String ArtistName;
  final String ArtistImage;
  final String WikiUrl;
  String article;

  Artists({required this.ArtistImage, required this.WikiUrl, required this.ArtistName, this.article = '', });

  factory Artists.fromJson(Map<String, dynamic> json){
    return Artists(
    ArtistImage: json['image'],
    ArtistName: json['artistName'],
    WikiUrl: json['wikipediaUrl'],
    );
  }

}



