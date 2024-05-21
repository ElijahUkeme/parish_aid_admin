import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';

Widget top(
    BuildContext context, Color color, String firstText, String secondText) {
  final Color backgroundColor = color;
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
      title: Txt(
        text: firstText,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(text: secondText),
      trailing: CircleAvatar(
        backgroundColor: color,
        child: const Icon(
          Icons.login,
          color: Colors.white,
        ),
      ),
    ),
  );
}
