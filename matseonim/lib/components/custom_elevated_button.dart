import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;

  final Color? color;
  final TextStyle? textStyle;
  final void Function()? funPageRoute;

  const CustomElevatedButton({required this.text, this.textStyle, this.color, this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: funPageRoute,
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text, 
          style: textStyle ?? const TextStyle(
            color: Colors.black
          )
        ),
      )
    );
  }
}
