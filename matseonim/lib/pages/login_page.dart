import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/login_elevated_button.dart';
import 'package:matseonim/components/login_form_field.dart';
import 'package:matseonim/pages/main_page.dart';
import 'package:matseonim/utils/validator.dart';

class LoginPage extends StatelessWidget {
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
                "이메일로 로그인",
                style: TextStyle(
                  fontSize: 32, 
                  color: Colors.white
                ),
              ),
            ),
            _emailLoginForm(),
          ],
        ),
      ),
    );
  }
}

Widget _emailLoginForm() {
  final _formKey = GlobalKey<FormState>();

  return Form(
    key: _formKey,
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
          funValidator: validatePassword(),
        ),
        LoginElevatedButton(
          text: "로그인",
          funPageRoute: () {
            if (_formKey.currentState!.validate()) {
              Get.to(MainPage());
            }
          },
        ),
      ],
    ),
  );
}
