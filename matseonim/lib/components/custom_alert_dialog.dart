import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;

  const CustomAlertDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "맞선임",
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            '확인',
            style: TextStyle(
              fontSize: 16
            )
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center
    );
  }
}
