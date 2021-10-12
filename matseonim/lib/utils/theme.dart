import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

const Color msiPrimaryColor = Color(0xFF0D47A1);
const Color msiBackgroundColor = Color(0xFF0D47A1);

/*
  "글꼴의 크기는 16픽셀의 배수로 맞추어 주시기 바랍니다. 글꼴의 크기가 16픽셀의 배수가 아닌 경우에는 
  글자의 윤곽선 중 일부가 디스플레이의 픽셀 경계 사이에 걸치기 때문에 글자가 흐릿하게 표시됩니다."

  "볼드체나 이탤릭체 등의 글꼴 스타일을 적용하지 마세요. 텍스트가 못나게 표시됩니다."
  
  - https://neodgm.dalgona.dev/guides.html
*/
final ThemeData msiThemeData = ThemeData(
  primaryColor: msiPrimaryColor,
  backgroundColor: msiBackgroundColor,
  fontFamily: "NeoPixel",
  textTheme: const TextTheme(
    headline6: TextStyle(fontSize: 32),
    subtitle1: TextStyle(fontSize: 16),
    bodyText1: TextStyle(fontSize: 16),
    bodyText2: TextStyle(fontSize: 16),
  )
);

class MSIChatTheme extends ChatTheme {
  const MSIChatTheme({
    Widget? attachmentButtonIcon,
    Color backgroundColor = neutral7,
    TextStyle dateDividerTextStyle = const TextStyle(
      color: neutral2,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    Widget? deliveredIcon,
    Widget? documentIcon,
    TextStyle emptyChatPlaceholderTextStyle = const TextStyle(
      color: neutral2,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    Color errorColor = error,
    Widget? errorIcon,
    Color inputBackgroundColor = neutral0,
    BorderRadius inputBorderRadius = const BorderRadius.all(Radius.zero),
    EdgeInsetsGeometry inputPadding = EdgeInsets.zero,
    Color inputTextColor = neutral7,
    Color? inputTextCursorColor,
    InputDecoration inputTextDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.zero,
      isCollapsed: true,
    ),
    TextStyle inputTextStyle = const TextStyle(
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    double messageBorderRadius = 10,
    double messageInsetsHorizontal = 16,
    double messageInsetsVertical = 16,
    Color primaryColor = msiPrimaryColor,
    TextStyle receivedMessageBodyTextStyle = const TextStyle(
      color: neutral0,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle receivedMessageCaptionTextStyle = const TextStyle(
      color: neutral2,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color receivedMessageDocumentIconColor = msiPrimaryColor,
    TextStyle receivedMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral0,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle receivedMessageLinkTitleTextStyle = const TextStyle(
      color: neutral0,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    Color secondaryColor = secondary,
    Widget? seenIcon,
    Widget? sendButtonIcon,
    Widget? sendingIcon,
    TextStyle sentMessageBodyTextStyle = const TextStyle(
      color: neutral7,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
    TextStyle sentMessageCaptionTextStyle = const TextStyle(
      color: neutral7WithOpacity,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.333,
    ),
    Color sentMessageDocumentIconColor = neutral7,
    TextStyle sentMessageLinkDescriptionTextStyle = const TextStyle(
      color: neutral7,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.428,
    ),
    TextStyle sentMessageLinkTitleTextStyle = const TextStyle(
      color: neutral7,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.375,
    ),
    Color userAvatarImageBackgroundColor = Colors.transparent,
    List<Color> userAvatarNameColors = const <Color>[msiPrimaryColor],
    TextStyle userAvatarTextStyle = const TextStyle(
      color: neutral7,
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
    TextStyle userNameTextStyle = const TextStyle(
      fontFamily: "NeoPixel",
      fontSize: 16,
      fontWeight: FontWeight.w800,
      height: 1.333,
    ),
  }) : super(
    attachmentButtonIcon: attachmentButtonIcon,
    backgroundColor: backgroundColor,
    dateDividerTextStyle: dateDividerTextStyle,
    deliveredIcon: deliveredIcon,
    documentIcon: documentIcon,
    emptyChatPlaceholderTextStyle: emptyChatPlaceholderTextStyle,
    errorColor: errorColor,
    errorIcon: errorIcon,
    inputBackgroundColor: inputBackgroundColor,
    inputBorderRadius: inputBorderRadius,
    inputPadding: inputPadding,
    inputTextColor: inputTextColor,
    inputTextCursorColor: inputTextCursorColor,
    inputTextDecoration: inputTextDecoration,
    inputTextStyle: inputTextStyle,
    messageBorderRadius: messageBorderRadius,
    messageInsetsHorizontal: messageInsetsHorizontal,
    messageInsetsVertical: messageInsetsVertical,
    primaryColor: primaryColor,
    receivedMessageBodyTextStyle: receivedMessageBodyTextStyle,
    receivedMessageCaptionTextStyle: receivedMessageCaptionTextStyle,
    receivedMessageDocumentIconColor: receivedMessageDocumentIconColor,
    receivedMessageLinkDescriptionTextStyle:
    receivedMessageLinkDescriptionTextStyle,
    receivedMessageLinkTitleTextStyle: receivedMessageLinkTitleTextStyle,
    secondaryColor: secondaryColor,
    seenIcon: seenIcon,
    sendButtonIcon: sendButtonIcon,
    sendingIcon: sendingIcon,
    sentMessageBodyTextStyle: sentMessageBodyTextStyle,
    sentMessageCaptionTextStyle: sentMessageCaptionTextStyle,
    sentMessageDocumentIconColor: sentMessageDocumentIconColor,
    sentMessageLinkDescriptionTextStyle:
    sentMessageLinkDescriptionTextStyle,
    sentMessageLinkTitleTextStyle: sentMessageLinkTitleTextStyle,
    userAvatarImageBackgroundColor: userAvatarImageBackgroundColor,
    userAvatarNameColors: userAvatarNameColors,
    userAvatarTextStyle: userAvatarTextStyle,
    userNameTextStyle: userNameTextStyle,
  );
}