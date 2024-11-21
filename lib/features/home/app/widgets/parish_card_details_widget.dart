import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';

Widget topCard(BuildContext context,String email) {
  final Color backgroundColor = Colors.blue.shade900.withOpacity(0.8);
  return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: ListTile(
          // leading: null,///You can use if you want;
          title: const Txt(
            text: "Login to",
            fontWeight: FontWeight.bold,
          ),
          subtitle: Txt(text: "Email: $email"),
      ));
}

Widget bottomCard(String name, String address) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 2.5),
    decoration: BoxDecoration(
        color: Colors.blue.shade900.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        )),
    child: ListTile(
      title: Txt(
        text: "Name: $name",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: "Address: $address",
        color: Colors.white,
      ),
    ),
  );
}
