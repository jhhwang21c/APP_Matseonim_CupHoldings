import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matseonim/components/autocomplete_form.dart';

import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_form_field.dart';
import 'package:matseonim/components/multiline_textfield.dart';
import 'package:matseonim/pages/drawer_page.dart';

class RequestPage extends StatelessWidget {

  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var interestTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text("의뢰하기", style: TextStyle(fontSize: 32)),
            ),
            ObscurableFormField(shouldObscure: false, textController: titleTextController, hintText: "제목"),
            SizedBox(height: 20),
            MultiLineTextField(textController: descriptionTextController),
            SizedBox(height: 20),
            AutocompleteForm(
              hintText: "요청분야를 입력해주세요",
              textController: interestTextController,
            ),
          ],
        ),
      ),
    );
  }

}
