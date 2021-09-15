import 'package:flutter/material.dart';

// primary color = 앱의 브랜드 색상
// secondary color (accent color) = 앱의 버튼이나, 상호작용 하는 색상

ThemeData theme() {
  return ThemeData(
    backgroundColor: Colors.blue[900],
    fontFamily: "NeoPixel"  // if !(16픽셀의 배수) else 깨짐
  );
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}