import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/components/autocomplete_form.dart';
import 'package:matseonim/components/custom_alert_dialog.dart';
import 'package:matseonim/components/custom_app_bar.dart';
import 'package:matseonim/components/custom_circle_avatar.dart';
import 'package:matseonim/components/custom_elevated_button.dart';
import 'package:matseonim/components/custom_form_field.dart';
import 'package:matseonim/components/multiline_textfield.dart';
import 'package:matseonim/models/storage.dart';
import 'package:matseonim/models/user.dart';
import 'package:matseonim/pages/drawer_page.dart';
import 'package:matseonim/utils/validator.dart';

class MyAccountPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _MyAccountWidget1()
      )
    );
  }
}

class MyAccountPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _MyAccountWidget2()
      ),
    );
  }
}

class _MyAccountWidget1 extends StatelessWidget {
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
              Column(
                children: [
                  const Text(
                    "내 정보",
                    style: TextStyle(
                      fontSize: 32
                    )
                  ),
                  const SizedBox(height: 32),
                  _MyAccountAvatar(user: user),
                  const SizedBox(height: 32),
                  _MyAccountForm1(user: user)
                ],                  
              )
            ]
          );
        }
      }
    );
  }
}

class _MyAccountWidget2 extends StatelessWidget {
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
                      "비밀번호 변경",
                      style: TextStyle(
                        fontSize: 32
                      )
                    ),
                    const SizedBox(height: 32),
                    _MyAccountForm2(user: user)
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

class _MyAccountAvatarController extends GetxController {
  _MyAccountAvatarController();
}

class _MyAccountAvatar extends StatelessWidget {
  final MSIUser user;

  const _MyAccountAvatar({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_MyAccountAvatarController>(
      init: _MyAccountAvatarController(),
      builder: (_) => Stack(
        children: [
          CustomCircleAvatar(size: 250, url: user.avatarUrl ?? ""),
          Positioned(
            right: 0,
            bottom: 0,
            child: ElevatedButton(
              onPressed: () async {
                StorageStatus status = await MSIStorage.pickAvatar(user: user);

                if (status == StorageStatus.success) {
                  Get.dialog(
                    const CustomAlertDialog(
                      message: "프로필 사진이 변경되었습니다."
                    )
                  );
                } else {
                  Get.dialog(
                    const CustomAlertDialog(
                      message: "오류가 발생하였습니다. 다시 시도해주세요."
                    )
                  );
                }

                _.update();
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
      )
    );
  }
}

class _MyAccountForm1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final MSIUser user;

  var nameTextController = TextEditingController();
  var phoneNumberTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var professionTextController = TextEditingController();
  var interestTextController = TextEditingController();
  var resumeTextController = TextEditingController();

  _MyAccountForm1({
    Key? key,
    required this.user
  }) : super(key: key) {
    nameTextController.text = user.name ?? "?";
    phoneNumberTextController.text = user.phoneNumber ?? "?";
    emailTextController.text = user.email ?? "?";
    professionTextController.text = user.profession ?? "?";
    interestTextController.text = user.interest ?? "?";
    resumeTextController.text = user.interest ?? "경력이 없습니다.";
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
                  funPageRoute: () {
                    Get.to(MyAccountPage2());
                  }
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
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  child: const Text(
                    "내 경력",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                 MultiLineTextField(textController: resumeTextController),
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
              funPageRoute: () async {
                if (_formKey.currentState!.validate()) {
                  user.name = nameTextController.text;
                  user.phoneNumber = phoneNumberTextController.text;
                  user.email = emailTextController.text;
                  user.profession = professionTextController.text;
                  user.interest = interestTextController.text;

                  await user.update();

                  Get.dialog(
                    const CustomAlertDialog(
                      message: "계정 정보가 변경되었습니다."
                    )
                  ); 
                }
              }
            )
          )
        ]
      )
    );
  }
}

class _MyAccountForm2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final MSIUser user;

  final passwordTextController = TextEditingController();
  final newPasswordTextController = TextEditingController();
  final confirmNewPasswordTextController = TextEditingController();

  _MyAccountForm2({
    Key? key,
    required this.user
  }) : super(key: key);

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
                    "현재 비밀번호",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: true,
                  textController: passwordTextController,
                  funValidator: validatePassword()
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
                    "새 비밀번호",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: true,
                  textController: newPasswordTextController,
                  funValidator: validatePassword(saveValue: true)
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
                    "새 비밀번호 확인",
                    style: TextStyle(fontSize: 16),
                  )
                ),
                ObscurableFormField(
                  shouldObscure: true,
                  textController: confirmNewPasswordTextController,
                  funValidator: validateConfirmPassword()
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
              funPageRoute: () async {
                if (_formKey.currentState!.validate()) {
                  AuthStatus status = await user.changePassword(
                    oldPassword: passwordTextController.text,
                    newPassword: newPasswordTextController.text
                  );

                  if (status == AuthStatus.success) {
                    await Get.dialog(
                      const CustomAlertDialog(
                        message: "비밀번호가 변경되었습니다."
                      )
                    );

                    Get.back();
                  } else if (status == AuthStatus.userNotFound) {
                    Get.dialog(
                      const CustomAlertDialog(
                        message: "사용자를 찾을 수 없습니다. 다시 시도해주세요."
                      )
                    );
                  } else if (status == AuthStatus.wrongPassword) {
                    Get.dialog(
                      const CustomAlertDialog(
                        message: "현재 비밀번호가 틀렸습니다. 다시 시도해주세요."
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
              }
            )
          )
        ]
      )
    );
  }
}