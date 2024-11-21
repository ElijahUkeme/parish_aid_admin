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
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side:  BorderSide(color: Colors.blue.shade900.withOpacity(0.8), width: 1.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        onPressed: onPressed,
        child: text,
      ),
    );
  }
}
