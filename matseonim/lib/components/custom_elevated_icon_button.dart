import 'package:flutter/material.dart';

typedef _RouteCallback = void Function();

class CustomElevatedIconButton extends StatelessWidget {
  final Widget icon;
  final String text;

  final Color? color;
  final _RouteCallback? funPageRoute;

  const CustomElevatedIconButton({required this.icon, required this.text, this.color, this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton.icon(
        onPressed: funPageRoute,
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: icon, 
        label: Text(
          text, 
          style: const TextStyle(
            fontSize: 16, 
            color: Colors.black
          )
        )
      )
    );
  }
}
