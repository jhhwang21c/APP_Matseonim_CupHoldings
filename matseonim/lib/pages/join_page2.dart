import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/autocomplete_form.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/login_page.dart';

class JoinPage2 extends StatelessWidget {
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
            _JoinForm2()
          ],
        ),
      ),
    );
  }
}

class _JoinForm2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final professionTextController = TextEditingController();
  final interestTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              funPageRoute: () async {
                if (_formKey.currentState!.validate()) {
                  final MSIUser user = Get.arguments;

                  user.profession = professionTextController.text;
                  user.interest = interestTextController.text;
                  
                  AuthStatus status = await user.signUp();

                  if (status == AuthStatus.success) {
                    Get.dialog(
                      const CustomAlertDialog(
                        message: "회원가입이 완료되었습니다."
                      )
                    );

                    Get.to(LoginPage());
                  } else if (status == AuthStatus.emailAlreadyInUse) {
                    Get.dialog(
                      const CustomAlertDialog(
                        message: "이미 사용 중인 이메일 주소입니다."
                      )
                    );
                  } else {
                    Get.dialog(
                      const CustomAlertDialog(
                        message: "오류가 발생하였습니다. 다시 시도해주세요."
                      )
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
