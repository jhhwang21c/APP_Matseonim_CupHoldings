import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/login_elevated_button.dart';
import 'package:matseonim/components/login_form_field.dart';
import 'package:matseonim/pages/login_page.dart';
import 'package:matseonim/utils/validator.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text(
                "회원가입 정보",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            _joinForm()
          ],
        ),
      ),
    );
  }
}

Widget _joinForm() {
  final _formKey = GlobalKey<FormState>();
  var confirmPass;

  return Form(
    child: Column(
      children: [
        LoginFormField(
          shouldObscure: false,
          hintText: "이메일",
          funValidator: validateEmail(),
        ),
        LoginFormField(
          shouldObscure: true,
          hintText: "비밀번호",
          funValidator: (String? value) {
            confirmPass = value;
            if (value!.isEmpty) {
              return "공백이 들어갈 수 없습니다.";
            } else if (value.length < 8) {
              return "최소 8글자 이상 입력해주세요.";
            } else {
              return null;
            }
          },
        ),
        LoginFormField(
          shouldObscure: true,
          hintText: "비밀번호 확인",
          funValidator: (String? value) {
            confirmPass = value;
            if (value!.isEmpty) {
              return "공백이 들어갈 수 없습니다.";
            } else if (value.length < 8) {
              return "최소 8글자 이상 입력해주세요.";
            } else if (value != confirmPass) {
              return "위 비밀번호와 일치하지 않습니다.";
            } else {
              return null;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: LoginElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                Get.to(LoginPage());
              }
            },
          ),
        ),
      ],
    ),
  );
}
