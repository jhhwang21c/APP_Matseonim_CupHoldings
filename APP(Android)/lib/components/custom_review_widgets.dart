import 'package:flutter/material.dart';

import 'package:matseonim/models/review.dart';
import 'package:matseonim/models/user.dart';

class ReviewWidget extends StatelessWidget {
  final MSIReview review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MSIUser.init(uid: review.reviewerId),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIUser user = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    Text(user.name ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          const WidgetSpan(
                              child: Icon(
                            Icons.star,
                            size: 16.0,
                            color: Colors.amber,
                          )),
                          TextSpan(text: review.rating.toStringAsFixed(1))
                        ],
                      )
                    )
                  ]
                ),
                SizedBox(height: 6),
                Text(
                  review.value,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 6)
              ],
            );
          }
        });
  }
}

class ReviewListView extends StatelessWidget {
  final MSIUser reviewee;

  const ReviewListView({Key? key, required this.reviewee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MSIReviews.getFor(reviewee: reviewee),
      builder: (BuildContext context, AsyncSnapshot<List<MSIReview>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator()
          );
        } else {
          final List<MSIReview> reviews = snapshot.data!;

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: reviews.length,
              itemBuilder: (context, i) {
                return ReviewWidget(review: reviews[i]);
              }, 
              separatorBuilder: (context, i) { 
                return Divider(
                  thickness: 1,
                  color: Colors.grey,
                );
              },
            )
          );
        }
      },
    );
  }
}
