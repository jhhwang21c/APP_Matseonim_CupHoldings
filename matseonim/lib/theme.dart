import 'package:flutter/material.dart';

// primary color = 앱의 브랜드 색상
// secondary color (accent color) = 앱의 버튼이나, 상호작용 하는 색상

ThemeData theme() {
  return ThemeData(
    backgroundColor: Colors.indigo[900],
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}