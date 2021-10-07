import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matseonim/components/autocomplete_form.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_field.dart';
import 'package:matseonim/components/multiline_textfield.dart';
import 'package:matseonim/models/request.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/pages/main_page.dart';

class RequestPage extends StatelessWidget {
  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var interestTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: FutureBuilder(
        future: MSIUser.init(),
        builder: (BuildContext context, AsyncSnapshot<MSIUser> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
                child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
          } else {
            final MSIUser user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text("의뢰하기", style: TextStyle(fontSize: 32)),
                  ),
                  ObscurableFormField(
                      shouldObscure: false,
                      textController: titleTextController,
                      hintText: "제목"),
                  SizedBox(height: 20),
                  MultiLineTextField(textController: descriptionTextController),
                  SizedBox(height: 20),
                  AutocompleteForm(
                    hintText: "요청분야를 입력해주세요",
                    textController: interestTextController,
                  ),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                      text: "요청하기",
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.white),
                      color: Theme.of(context).primaryColor,
                      funPageRoute: () {
                        MSIRequests.add(
                          uid: '${user.uid}',
                          title: titleTextController.text,
                          description: descriptionTextController.text,
                          interest: interestTextController.text,
                        );
                        Get.to(MainPage());
                      })
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
