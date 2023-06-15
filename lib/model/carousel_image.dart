import 'dart:convert';

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
