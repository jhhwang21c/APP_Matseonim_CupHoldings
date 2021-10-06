import 'package:flutter/material.dart';

class MultiLineTextField extends StatelessWidget {
 
  final TextEditingController textController;

  MultiLineTextField({required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      minLines: 5,
      maxLines: 20,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          hintText: '내용을 입력하세요',
          hintStyle: TextStyle(fontSize: 16),
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
            ),),
    );
  }
}
