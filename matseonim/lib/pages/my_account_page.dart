import 'package:flutter/material.dart';

import 'package:matseonim/components/autocomplete_form.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_field.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/utils/validator.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _EditableProfile()
      )
    );
  }
}

class _EditableProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          
          return ListView(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "내 정보",
                      style: TextStyle(
                        fontSize: 32
                      )
                    ),
                    const SizedBox(height: 32),
                    _EditableAvatar(user: user),
                    const SizedBox(height: 32),
                    _EditableForm(user: user)
                  ],                  
                )
              )
            ]
          );
        }
      }
    );
  }
}

class _EditableAvatar extends StatelessWidget {
  final MSIUser user;

  const _EditableAvatar({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCircleAvatar(size: 250, url: user.avatarUrl ?? ""),
        Positioned(
          right: 0,
          bottom: 0,
          child: ElevatedButton(
            onPressed: () {
              /* TODO: ... */
            },
            child: const Icon(Icons.edit),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              primary: Theme.of(context).primaryColor
            ),
          )
        )
      ]
    );
  }
}

class _EditableForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final MSIUser user;

  var nameTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var professionTextController = TextEditingController();
  var interestTextController = TextEditingController();

  _EditableForm({
    Key? key,
    required this.user
  }) : super(key: key) {
    nameTextController.text = user.name ?? "?";
    phoneNumberTextController.text = user.phoneNumber ?? "?";
    emailTextController.text = user.email ?? "?";
    professionTextController.text = user.profession ?? "?";
    interestTextController.text = user.interest ?? "?";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "성명",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: false,
                  textController: nameTextController,
                  funValidator: validateName()
                )
              ]
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "휴대폰 번호",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: false,
                  textController: phoneNumberTextController,
                  funValidator: validatePhoneNumber()
                )
              ]
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "이메일",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: false,
                  textController: emailTextController,
                  funValidator: validateEmail()
                )
              ]
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "비밀번호",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                CustomElevatedButton(
                  text: "비밀번호 변경",
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                  color: Theme.of(context).primaryColor,
                  funPageRoute: () {}
                )
              ]
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "전문 분야",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                AutocompleteForm(
                  hintText: "전문 분야를 입력해 주세요",
                  textController: professionTextController,
                )
              ]
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "관심 분야",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                AutocompleteForm(
                  hintText: "관심 분야를 입력해 주세요",
                  textController: interestTextController,
                )
              ]
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
              text: "저장",
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.white
              ),
              color: Theme.of(context).primaryColor,
              funPageRoute: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: ...
                }
              }
            )
          )
        ]
      )
    );
  }
}