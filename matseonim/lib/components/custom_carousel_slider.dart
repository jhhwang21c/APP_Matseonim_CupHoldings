import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Widget> items;

  const CustomCarouselSlider({
    Key? key,
    required this.items
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        height: 180,
      ),
      items: items,
    );
  }
}
