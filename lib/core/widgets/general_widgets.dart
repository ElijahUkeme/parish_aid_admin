
import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    toolbarHeight: 35,
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor:
    Colors.blue.shade900.withOpacity(0.10),
    title:  Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    centerTitle: true,
  );
}