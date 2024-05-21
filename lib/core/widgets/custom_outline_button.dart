import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Widget text;
  final Function() onPressed;
  const CustomOutlineButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF008384), width: 1.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
