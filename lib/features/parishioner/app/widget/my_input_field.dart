

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key? key,required this.title,
    required this.hint,this.controller,
    this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(left: 18,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.0,),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 14),
            height: 43,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                    width: 1.0
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow:
                const [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                      color: Colors.white
                  )
                ]
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                        readOnly: widget==null?false:true,
                        autofocus: false,
                        cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                        controller: controller,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900.withOpacity(0.8)),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: ( TextStyle(
                              color: Colors.black.withOpacity(0.6)
                          )),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0
                              )
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0
                            ),
                          ),
                        )
                    )),
                widget==null?Container():Container(child: widget,)],
            ),
          )
        ],
      ),
    );
  }
}