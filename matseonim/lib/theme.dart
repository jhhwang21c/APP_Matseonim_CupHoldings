import 'package:flutter/material.dart';

/*
  Primary Color: 앱의 브랜드 색상
  Secondary Color (Accent Color): 앱의 구성 요소와의 상호작용과 관련된 색상
*/

ThemeData defaultTheme() {
  /*
    "글꼴의 크기는 16픽셀의 배수로 맞추어 주시기 바랍니다. 글꼴의 크기가 16픽셀의 배수가 아닌 경우에는 
    글자의 윤곽선 중 일부가 디스플레이의 픽셀 경계 사이에 걸치기 때문에 글자가 흐릿하게 표시됩니다."

    "볼드체나 이탤릭체 등의 글꼴 스타일을 적용하지 마세요. 텍스트가 못나게 표시됩니다."
    
    - https://neodgm.dalgona.dev/guides.html
  */

  return ThemeData(
      backgroundColor: Colors.blue[900],
      primaryColor: Colors.blue[900],
      fontFamily: "NeoPixel",
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 32),
        subtitle1: TextStyle(fontSize: 16),
        bodyText1: TextStyle(fontSize: 16),
        bodyText2: TextStyle(fontSize: 16),
      ),
      );
}
