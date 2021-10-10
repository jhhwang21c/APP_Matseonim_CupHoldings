import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/read_request_page.dart';

List<Widget> buildItemsFromRequests({
  required BuildContext context,
  required List<MSIRequest> requests,
  required MSIUser user
}) {
  if (requests.isEmpty) {
    return <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Center(
            child: Text(
              "새로운 의뢰가 없습니다.",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center
            )
          )
        )
      )
    ];
  } else {
    return requests.map(
      (MSIRequest request) => Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.35,
        margin: const EdgeInsets.all(5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    "${request.title}\n\n${request.description}",
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center
                  )
                ),
                SizedBox(
                  height: 40,
                  child: CustomElevatedButton(
                    color: Colors.blue[900],
                    text: "더 보기",
                    textStyle: const TextStyle(
                        fontSize: 16, color: Colors.white),
                    funPageRoute: () {
                      Get.to(ReadRequestPage(request: request));
                    }
                  ),
                )
              ]
            )
          )
        )
      )
    ).toList();
  }
}

class CustomCarouselSlider extends StatelessWidget {
  final MSIUser user;
  
  final String field;

  const CustomCarouselSlider({
    Key? key,
    required this.user,
    required this.field
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIRequests.getIncoming(uid: user.uid!, field: field),
      builder: (BuildContext context, AsyncSnapshot<List<MSIRequest>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator()
            )
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              height: 200,
            ),
            items: buildItemsFromRequests(
              context: context,
              requests: snapshot.data!,
              user: user
            ),
          );
        }
      }
    );
  }
}