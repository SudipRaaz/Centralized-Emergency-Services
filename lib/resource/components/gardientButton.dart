import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyGradientButton extends StatelessWidget {
  // variables for buttons class
  final String text;
  final VoidCallback onPress;
  final LinearGradient? gradientColor;
  final IconData? iconData;

  // constructor
  const MyGradientButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.gradientColor,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        elevation: 5,
      ),
      onPressed: onPress,
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradientColor ??
              const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 187, 126, 248)]),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minWidth: 88.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Colors.red[400],
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
              const Icon(null),
            ],
          ),
        ),
      ),
    );
  }
}
