import 'package:validators/validators.dart';

typedef Validator = String? Function(String?);

Validator validateEmail() {
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

Validator validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다";
    } else if (value.length < 8) {
      return "최소 8글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}

Validator validateConfirmPassword(String s) {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length < 8) {
      return "최소 8글자 이상 입력해주세요.";
    } else if (!matches(value, s)) {
      return "위 비밀번호와 일치하지 않습니다.";
    } else {
      return null;
    }
  };
}

Validator validatePhoneNumber() {
  return (String? value) {
    RegExp expr = RegExp(r"/^\d{3}-\d{4}-\d{4}$/");

    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (!expr.hasMatch(value)) {
      return "010-XXXX-XXXX와 같이 입력해주세요.";
    } else {
      return null;
    }
  };
}

Validator validateName() {
  return (String? value) {
    if (value!.isEmpty) {
      return "공백이 들어갈 수 없습니다.";
    } else if (value.length < 2) {
      return "최소 2글자 이상 입력해주세요.";
    } else {
      return null;
    }
  };
}