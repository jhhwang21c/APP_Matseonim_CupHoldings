import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matseonim/util/validator.dart';
import 'package:matseonim/components/custom_text_form_field.dart';

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
                    fontSize: 30,
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

  return Form(
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
        CustomTextFormField(
          hint: "비밀번호 확인",
          funValidator: validatePassword(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomElevatedButton(
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
