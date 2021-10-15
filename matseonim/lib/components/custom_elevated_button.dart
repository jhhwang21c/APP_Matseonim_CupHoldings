import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;

  final Color? color;
  final TextStyle? textStyle;
  final Size? size;
  final double? elevation;
  final void Function()? funPageRoute;

  const CustomElevatedButton({
    Key? key,
    required this.text, 
    this.textStyle, 
    this.color, 
    this.funPageRoute, 
    this.size, this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: funPageRoute,
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white,
          minimumSize: size ?? const Size(double.infinity, 50),
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text, 
          style: textStyle ?? const TextStyle(
            fontSize: 16, 
            color: Colors.black
          )
        ),
      )
    );
  }
}
