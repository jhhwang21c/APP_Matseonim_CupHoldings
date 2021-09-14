import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/components/custom_text_form_field.dart';
import 'package:client/components/custom_elevated_button.dart';
import 'package:client/util/validator.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "이메일로 로그인",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _loginForm(),
          ],
        ),
      ),
    );
  }
}

Widget _loginForm() {
  final _formKey = GlobalKey<FormState>();

  return Form(
    key: _formKey,
    child: Column(
      children: [
        CustomTextFormField(
          hint: "이메일",
          funValidator: validateEmail(),
        ),
        CustomTextFormField(
          hint: "비밀번호",
          funValidator: validatePassword(),
        ),
        CustomElevatedButton(
          text: "로그인",
          funPageRoute: () {
            if (_formKey.currentState!.validate()) {
              Get.to(LoginPage());
            }
          },
        ),
      ],
    ),
  );
}
