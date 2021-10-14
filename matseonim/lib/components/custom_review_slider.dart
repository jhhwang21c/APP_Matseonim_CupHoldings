import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:matseonim/models/review.dart';

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
                  child: Text("후기가 없습니다.",
                      style: TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center))))
    ];
  } else {
    return reviews
        .map(
          (MSIReview review) => Container(
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
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            review.value,
                            style: const TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}

class CustomReviewSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MSIReviews.getAll(),
        builder:
            (BuildContext context, AsyncSnapshot<List<MSIReview>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          } else {
            final List<MSIReview> reviews = snapshot.data!;

            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: false,
                height: 200,
              ),
              items: _buildItemsFromReviews(
                context: context,
                reviews: reviews,
              ),
            );
          }
        });
  }
}
