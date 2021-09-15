import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/login_elevated_button.dart';
import 'package:matseonim/components/login_form_field.dart';
import 'package:matseonim/pages/login_page.dart';
import 'package:matseonim/utils/validator.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                    color: Colors.white
                ),
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

  return Form(
    child: Column(
      children: [
        LoginFormField(
          hintText: "이메일",
          funValidator: validateEmail(),
        ),
        LoginFormField(
          hintText: "비밀번호",
          funValidator: validatePassword(),
        ),
        LoginFormField(
          hintText: "비밀번호 확인",
          funValidator: validatePassword(),
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
