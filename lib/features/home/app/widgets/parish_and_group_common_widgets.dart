

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commonRichText(double fontSize,String firstText,String secondText) {
  return Text.rich(
    TextSpan(
      style: GoogleFonts.inter(
        fontSize: fontSize,
        color: Colors.blue.shade900,
        letterSpacing: 2.000000061035156,
      ),
      children: [
         TextSpan(
          text: firstText,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: secondText,
          style: TextStyle(
            color: Colors.blue.shade900.withOpacity(0.2),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

Widget commonActionButton(Size size, String text) {
  return // Group: Button
    Container(
      alignment: Alignment.center,
      height: size.height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.blue.shade900,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C2E84).withOpacity(0.2),
            offset: const Offset(0, 15.0),
            blurRadius: 60.0,
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
}