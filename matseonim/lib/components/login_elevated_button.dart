import 'package:flutter/material.dart';

typedef _RouteCallback = void Function();

class LoginElevatedButton extends StatelessWidget {
  final String text;
  final _RouteCallback? funPageRoute;

  const LoginElevatedButton({required this.text, this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: funPageRoute,
        child: Text(
          text, 
          style: TextStyle(
            fontSize: 16, 
            color: Colors.black
          )
        ),
      )
    );
  }
}
