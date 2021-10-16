import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/review.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/read_request_page.dart';

import 'custom_profile_widgets.dart';

List<Widget> _buildItemsFromRequests({
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
            child: Text("새로운 의뢰가 없습니다.",
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
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.35,
        margin: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(request.title,
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(height: 8),
                      Text(request.description,
                          style: const TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.start,
                          maxLines: 6,),
                    ]
                  )
                ),
                SizedBox(
                  height: 40,
                  child: CustomElevatedButton(
                    color: Colors.blue[900],
                    text: "더 보기",
                    textStyle: const TextStyle(
                      fontSize: 16, 
                      color: Colors.white
                    ),
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

List<Widget> _buildItemsFromReviews({
  required BuildContext context,
  required List<MSIReview> reviews,
}) {
  if (reviews.isEmpty) {
    return <Widget>[
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Center(
            child: Text(
              "사용자 후기가 없습니다.",
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center
            )
          )
        )
      )
    ];
  } else {
    return reviews.map(
      (MSIReview review) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.35,
        margin: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallProfile2(uid: review.reviewerId, imageSize: 40,),
                    Icon(Icons.forward),
                    SmallProfile2(uid: review.revieweeId, imageSize: 40,),
                  ],
                ),
                Text(
                  review.value,
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.start,
                )
              ]
            ),
          ),
        ),
      ),
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
      future: MSIRequests.getIncoming(user: user),
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
              enlargeCenterPage: false,
              height: 200,
            ),
            items: _buildItemsFromRequests(
              context: context, requests: snapshot.data!, user: user
            ),
          );
        }
      }
    );
  }
}

class CustomReviewSlider extends StatelessWidget {
  const CustomReviewSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIReviews.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<MSIReview>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
          );
        } else {
          final List<MSIReview> reviews = snapshot.data!;

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              enlargeCenterPage: false,
              height: 230,
            ),
            items: _buildItemsFromReviews(
              context: context,
              reviews: reviews,
            ),
          );
        }
      }
    );
  }
}
