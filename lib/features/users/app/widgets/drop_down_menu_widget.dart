import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DropDownMenu extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  const DropDownMenu(
      {Key? key, required this.title, required this.hint, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(1, 1),
                      color: Colors.white)
                ]),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                        readOnly: widget == null ? false : true,
                        autofocus: false,
                        cursorColor: Get.isDarkMode
                            ? Colors.grey[100]
                            : Colors.grey[700],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: (TextStyle(color: Colors.blue.shade900)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ))),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
