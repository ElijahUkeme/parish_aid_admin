import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../common/colors.dart';

Widget socialButton(IconData icon) {
  return Container(
    height: 20,
    margin: const EdgeInsets.symmetric(vertical: 30),
    decoration: BoxDecoration(
        color: const Color(0xFFF1F3F6),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(10, 10),
              color: const Color(0xFF4D70A6).withOpacity(0.2),
              blurRadius: 16),
          const BoxShadow(
              offset: Offset(-10, -10),
              color: Color.fromARGB(170, 255, 255, 255),
              blurRadius: 10),
        ]),
    child: Icon(
      icon,
      color: const Color(0xFF4D70A6),
    ),
  );
}

AppBar buildAppBar(String type) {
  return AppBar(
    //backgroundColor: Colors.white,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Container(
        color: AppColors.primarySecondaryBackground,
        height: 1.0,
      ),
    ),
    title: Center(
      child: Text(
        type,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}

Widget reuseAbleText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
          fontStyle: FontStyle.normal,
          color: Colors.grey.withOpacity(0.5),
          fontSize: 14.sp),
    ),
  );
}

Widget forgotPasswordText(String text, void Function()? func) {
  return Container(
    height: 44.h,
    width: 260.w,
    margin: EdgeInsets.only(left: 30.w),
    child: GestureDetector(
      onTap: () {
        func;
      },
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.underline,
            decorationColor: Colors.grey,
            fontSize: 12.sp),
      ),
    ),
  );
}

buildLoginAndRegisterButton(String buttonText, Color buttonColor,
    Color textColor, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 40.h),
      decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Colors.grey.withOpacity(0.1))
          ]),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.normal, color: textColor),
        ),
      ),
    ),
  );
}

Widget buildTextField(
    String hintText, String inputType, void Function(String value)? func) {
  return TextField(
    onChanged: (value) => func!(value),
    style: const TextStyle(color: Color(0xFF4D70A6)),
    obscureText: inputType == "password" ? true : false,
    decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4D70A6), width: 2),
        ),
        labelText: hintText,
        labelStyle: const TextStyle(color: Color(0xFF4D70A6), fontSize: 14)),
  );
}

toastInfo({
  required String msg,
  Color backgroundColor = Colors.grey,
  Color textColor = Colors.white,
}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      timeInSecForIosWeb: 2,
      fontSize: 16.sp,
      textColor: textColor);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Route scaleIn(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, page) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return ScaleTransition(
        scale: animation.drive(tween),
        child: page,
      );
    },
  );
}

Widget buildLoadingIndicator() {
  return const SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
      backgroundColor: Colors.blue,
      strokeWidth: 3,
    ),
  );
}
