import 'package:validators/validators.dart';

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

Function validateUsername() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (!isAlphanumeric(value)) {
      return "영문과 숫자만 입력해주세요.";
    } else if (value.length < 4) {
      return "최소 4글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}

Function validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다";
    } else if (value.length < 4) {
      return "최소 4글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}