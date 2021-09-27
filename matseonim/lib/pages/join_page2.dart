import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/autocomplete_form.dart';
import 'package:matseonim/database/msi_user.dart';
import 'package:matseonim/pages/login_page.dart';

class JoinPage2 extends StatelessWidget {
  final MSIUser user;

  const JoinPage2({Key? key, required this.user}) : super(key: key);

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
                "회원가입 (2/2)",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
            _joinForm(user)
          ],
        ),
      ),
    );
  }
}

Widget _joinForm(MSIUser user) {
  final _formKey = GlobalKey<FormState>();

  final professionTextController = TextEditingController();
  final interestTextController = TextEditingController();

  return Form(
    key: _formKey,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AutocompleteForm(
            hintText: "전문 분야를 입력해 주세요",
            textController: professionTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AutocompleteForm(
            hintText: "관심 분야를 입력해 주세요",
            textController: interestTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                user.profession = professionTextController.text;
                user.interest = interestTextController.text;
                
                user.signUp(onComplete: () async {
                  Get.dialog(const CustomAlertDialog(message: "회원가입이 완료되었습니다.")).then(
                    (_) => Get.to(LoginPage())
                  );
                });
              }
            },
          ),
        ),
      ],
    ),
  );
}
