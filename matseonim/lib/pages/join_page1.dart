import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_field.dart';
import 'package:matseonim/database/msi_user.dart';
import 'package:matseonim/pages/join_page2.dart';
import 'package:matseonim/utils/validator.dart';

class JoinPage1 extends StatelessWidget {
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
                "회원가입 (1/2)",
                style: TextStyle(fontSize: 32, color: Colors.white),
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

  final nameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  return Form(
    key: _formKey,
    child: Column(
      children: [
        CustomFormField(
          shouldObscure: false,
          hintText: "성명",
          funValidator: validateName(),
          textController: nameTextController,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CustomFormField(
            shouldObscure: false,
            hintText: "휴대폰 번호 (010-XXXX-XXXX)",
            funValidator: validatePhoneNumber(),
            textController: phoneNumberTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CustomFormField(
            shouldObscure: false,
            hintText: "이메일",
            funValidator: validateEmail(),
            textController: emailTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CustomFormField(
              shouldObscure: true,
              hintText: "비밀번호",
              funValidator: validatePassword(),
              textController: passwordTextController),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: CustomFormField(
            shouldObscure: true,
            hintText: "비밀번호 확인",
            funValidator: validateConfirmPassword(),
            textController: confirmPasswordTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomElevatedButton(
            text: "다음",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                Get.to(
                  JoinPage2(
                    user: MSIUser(
                      name: nameTextController.text,
                      phoneNumber: phoneNumberTextController.text,
                      email: emailTextController.text,
                      password: passwordTextController.text
                    )
                  )
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
