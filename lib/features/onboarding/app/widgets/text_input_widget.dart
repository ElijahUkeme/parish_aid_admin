
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textInputField(Size size, String hintText, IconData icon,
    bool isObscured, Function(String value)? func) {
  return SizedBox(

    height: size.height / 13,
    child: TextField(
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      obscureText: isObscured,
      onChanged: func,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.8),
            )),
        prefixIcon: Icon(
          icon,
          color: Colors.blue.shade900.withOpacity(0.8),
          size: 16,
        ),
      ),
    ),
  );
}