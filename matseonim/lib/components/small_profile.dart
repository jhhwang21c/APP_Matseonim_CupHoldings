import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            backgroundImage:
                AssetImage("images/sampleAvatar.jpg"), // TODO: 서버에서 이미지 불러오기
          ),
        ),
        SizedBox(height: 10),
        Text(
          "홍길동",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "헬스",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}