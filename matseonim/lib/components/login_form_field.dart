import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:matseonim/utils/validator.dart';

class LoginFormFieldController extends GetxController {
  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    update();
  }
}

class LoginFormField extends GetView<LoginFormFieldController> {
  final String? hintText;
  final Validator funValidator;

  LoginFormField({required this.hintText, required this.funValidator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GetBuilder<LoginFormFieldController>(
        init: LoginFormFieldController(),
        global: false,
        builder: (_) => TextFormField(
          obscureText: _.obscureText,
          validator: funValidator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(
                _.obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _.toggleObscureText,
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
          )
        )
      )
    );
  }
}

