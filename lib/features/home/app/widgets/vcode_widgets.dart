
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/txt.dart';

Widget vCodeTopCard(BuildContext context, String id) {
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
          text: "View code details",
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(text: "Id: $id"),
      ));
}

Widget vCodeBottomCard(String code, String batchNo) {
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
        text: "Code: $code",
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Txt(
        text: "Batch Number: $batchNo",
        color: Colors.white,
      ),
    ),
  );
}