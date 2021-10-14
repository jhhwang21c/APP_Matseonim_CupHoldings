import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_fields.dart';
import 'package:matseonim/models/inquiry.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/main_page.dart';
import 'package:matseonim/utils/validator.dart';

class InquiryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: MSIUser.init(),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              )
            );
          } else {
            final MSIUser user = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _CreateRequestForm(user: user)
            );
          }
        },
      ),
    );
  }
}

class _CreateRequestForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final MSIUser user;

  _CreateRequestForm({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "문의하기", 
              style: TextStyle(fontSize: 32)
            ),
          ),
          ObscurableFormField(
            shouldObscure: false,
            hintText: "문의 제목",
            funValidator: validateText(),
            textController: titleTextController,
          ),
          SizedBox(height: 20),
          MultilineFormField(
            textController: descriptionTextController,
            funValidator: validateText()
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            text: "제출하기",
            textStyle: const TextStyle(
              fontSize: 16, 
              color: Colors.white
            ),
            color: Theme.of(context).primaryColor,
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                await MSIInquiries.add(
                  uid: '${user.uid}',
                  title: titleTextController.text,
                  description: descriptionTextController.text,
                );

                await Get.dialog(
                  const CustomAlertDialog(
                    message: "문의가 완료되었습니다.\n빠른 시일내에 조치하겠습니다."
                  )
                );

                Get.to(MainPage());
              }
            }
          )
        ],
      )
    );
  }
}
