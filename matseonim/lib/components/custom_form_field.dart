import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:matseonim/utils/validator.dart';

class ObscurableFormFieldController extends GetxController {
  bool obscureText = true;
  bool shouldObscure = false;

  ObscurableFormFieldController(this.shouldObscure);

  void toggleObscureText() {
    if (shouldObscure) {
      obscureText = !obscureText;
      update();
    }
  }
}

class ObscurableFormField extends GetView<ObscurableFormFieldController> {
  final bool shouldObscure;
  final Validator? funValidator;

  final String? hintText;
  final TextEditingController? textController;

  const ObscurableFormField({
    this.hintText,
    this.textController,
    required this.shouldObscure,
    this.funValidator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GetBuilder<ObscurableFormFieldController>(
        global: false,
        init: ObscurableFormFieldController(shouldObscure),
        dispose: (_) => textController?.dispose(),
        builder: (_) => TextFormField(
          controller: textController,
          obscureText: _.shouldObscure && _.obscureText,
          validator: funValidator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: _.shouldObscure ? IconButton(
              icon: Icon(
                _.obscureText
                ? Icons.visibility_off 
                : Icons.visibility,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _.toggleObscureText,
            ) : null,
            filled: true,
            fillColor: Colors.white,
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

