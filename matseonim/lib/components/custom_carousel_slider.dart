import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:matseonim/components/custom_elevated_button.dart';

class MainPageItem{
  String UID;
  String requestID;

  MainPageItem(this.UID, this.requestID);
}

final List<MainPageItem> itemList = [
  MainPageItem("uid", "requestid"),
];

final List<Widget> itemSliders = itemList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: [
                        Text('사연이 들어가는 부분', style: TextStyle(fontSize: 16.0),),
                      ],
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: SizedBox(width: 60, height: 40, 
                        child: CustomElevatedButton(
                            color: Colors.blue[900],
                            text: "자세히 보기",
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            funPageRoute: () {}),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class ItemSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        height: 180,
      ),
      items: itemSliders,
    );
  }
}
