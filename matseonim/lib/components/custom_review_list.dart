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
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;

            return Container(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(user.name ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            const WidgetSpan(
                                child: Icon(
                              Icons.star,
                              color: Colors.amber,
                            )),
                            TextSpan(text: review.rating.toStringAsFixed(1))
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                  Text(
                        review.value,
                        style: TextStyle(fontSize: 16),
                      ),
                  Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                ],
              ),
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
              child: const CircularProgressIndicator());
        } else {
          final List<MSIReview> reviews = snapshot.data!;
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              itemBuilder: (context, i) {
                return ReviewWidget(review: reviews[i]);
              });
        }
      },
    );
  }
}
