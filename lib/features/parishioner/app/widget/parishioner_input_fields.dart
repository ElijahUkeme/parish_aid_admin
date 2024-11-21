

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildParishionerInputFields(Size size,bool isParish, String input, String textHint,
    bool isObscured,String initialText, void Function(String value)? func) {
  return Container(
    margin: isParish?EdgeInsets.zero:const EdgeInsets.only(left: 15,right: 15),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          input,
          style: GoogleFonts.inter(
            fontSize: 14.0,
            color: Colors.black.withOpacity(0.5),
            height: 1.0,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        parishionerInputFieldBody(size, textHint, isObscured,initialText, func)
      ],
    ),
  );
}

Widget parishionerInputFieldBody(Size size, String textHint, bool isObscured,String initialText,
    void Function(String value)? func) {
  return SizedBox(
    height: size.height / 17,
    child: TextFormField(
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      obscureText: isObscured ? true : false,
      cursorColor: const Color(0xFF151624),
      initialValue: initialText,
      onChanged: (value) => func!(value),
      decoration: InputDecoration(
        //disabledBorder: InputBorder.none,
        hintText: textHint,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.0,
          color: const Color(0xFFABB3BB),
          height: 1.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3), width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3), width: 0.8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5), width: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}
