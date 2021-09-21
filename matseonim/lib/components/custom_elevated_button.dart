import 'package:flutter/material.dart';

typedef _RouteCallback = void Function();

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final _RouteCallback? funPageRoute;

  const CustomElevatedButton({required this.text, this.funPageRoute, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: funPageRoute,
        child: Text(
          text, 
          style: const TextStyle(
            fontSize: 16, 
            color: Colors.black
          )
        ),
      )
    );
  }
}
