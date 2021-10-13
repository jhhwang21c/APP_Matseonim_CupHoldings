import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matseonim/components/custom_alert_dialog.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_fields.dart';
import 'package:matseonim/components/custom_profile_widgets.dart';
import 'package:matseonim/components/custom_rating_bar.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/utils/validator.dart';

class ReviewPage extends StatelessWidget {
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
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

  final descriptionTextController = TextEditingController();

  final MSIUser user;
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것
  //백엔드 부분은 알아서 할 것

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
              "리뷰쓰기",
              style: TextStyle(fontSize: 32)
            ),
          ),
          ReviewProfile(),
          SizedBox(height: 20),  //내가 평가하는 사람 uid 넘기기
          Center(child: CustomRatingBar(uid: user.uid!)),    //밑에 "작성완료" 버튼하고 연동하기
          SizedBox(height: 15),
          MultilineFormField(
            textController: descriptionTextController,
            funValidator: validateText()
          ),
          SizedBox(height: 20),
          CustomElevatedButton(
            text: "작성완료",
            textStyle: const TextStyle(
              fontSize: 16, 
              color: Colors.white
            ),
            color: Theme.of(context).primaryColor,
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {

                await Get.dialog(
                  const CustomAlertDialog(
                    message: "리뷰가 작성되었습니다."
                  )
                );

                Get.back();
              }
            }
          )
        ],
      )
    );
  }
}
