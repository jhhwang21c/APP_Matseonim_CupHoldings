import 'package:validators/validators.dart';

Function validateUsername() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다";
    } else if (!isAlphanumeric(value)) {
      return "영문과 숫자만 입력해 주세요";
    } else if (value.length > 12) {
      return "길이를 초과했습니다";
    } else if (value.length < 4) {
      return "최소 길이는 4 입니다.";
    } else {
      return null;
    }
  };
}

Function validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다";
    } else if (value.length > 12) {
      return "길이를 초과했습니다";
    } else if (value.length < 4) {
      return "최소 길이는 4 입니다.";
    } else {
      return null;
    }
  };
}

Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다";
    } else if (!isEmail(value)) {
      return "이메일 형식에 맞지 않습니다";
    } else {
      return null;
    }
  };
}
