import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'custom_elevated_button.dart';

class CustomRatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(width: 8,),
        Container(
          height: 55,
          width: 100,
          child: CustomElevatedButton(
              text: "평가제출",
              textStyle: TextStyle(color: Colors.white, fontSize: 16),
              color: Colors.blue[900],
              funPageRoute: () {}),
        ),
      ],
    );
  }
}
