import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/models/user.dart';

class CustomRatingBar extends StatelessWidget {
  final String uid;

  const CustomRatingBar({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        MSIUser.init(),
        MSIUser.init(uid: uid)
      ]), 
      builder: (BuildContext context, AsyncSnapshot<List<MSIUser>> snapshot) {  
        if (!snapshot.hasData) {
          return SizedBox(
                child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
        } else {
          final List<MSIUser> users = snapshot.data!;

          double newRating = 3.0;

          return 
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  newRating = rating;
                },
              );
        }
      },
    );
  }
}
