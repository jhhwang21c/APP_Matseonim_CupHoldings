import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:matseonim/utils/validator.dart';

class LoginFormFieldController extends GetxController {
  bool obscureText = true;
  bool shouldObscure = false;

  LoginFormFieldController(this.shouldObscure);

  void toggleObscureText() {
    if (shouldObscure) {
      obscureText = !obscureText;
      update();
    }
  }
}

class LoginFormField extends GetView<LoginFormFieldController> {
  final bool shouldObscure;

  final String? hintText;
  final Validator funValidator;

  LoginFormField({
    required this.shouldObscure, 
    required this.hintText, 
    required this.funValidator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GetBuilder<LoginFormFieldController>(
        init: LoginFormFieldController(shouldObscure),
        global: false,
        builder: (_) => TextFormField(
          obscureText: _.shouldObscure && _.obscureText,
          validator: funValidator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: IconButton(
              icon: Icon(
                (_.shouldObscure && _.obscureText) 
                ? Icons.visibility_off 
                : Icons.visibility,
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

