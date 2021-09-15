import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  //final String? hint;

  //const CustomPasswordFormField({required this.hint});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<CustomPasswordFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: !_passwordVisible,
        validator: validatePassword,
        decoration: InputDecoration(
          hintText: '비밀번호',  //"비밀번호 확인"은 어떻게 할지...
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
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  String? validatePassword(value) {
        if (value!.isEmpty) {
          return "공백이 들어갈 수 없습니다";
        } else if (value.length < 4) {
          return "최소 4글자 이상 입력해주세요.";
        } else {
          return null;
        }
      }
}
