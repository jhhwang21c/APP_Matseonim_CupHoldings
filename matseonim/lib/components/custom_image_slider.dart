import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<ImageProvider<Object>> imgList = [
  AssetImage('images/comment3.png'),
  AssetImage('images/comment1.png'),
  AssetImage('images/comment2.png'),
];

final List<Widget> imageSliders = imgList
    .map((ImageProvider<Object> item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 295.0,
                      width: 400.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: item,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class CommentsAboutMSI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            aspectRatio: 1.3333333,
            enlargeCenterPage: true,
          ),
          items: imageSliders,
        ),
    );
  }
}
