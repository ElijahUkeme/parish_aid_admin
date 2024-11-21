

import 'package:flutter/cupertino.dart';

import '../../../../core/helpers/txt.dart';

Widget detailsPageTextStart(String firstText, String secondText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Txt(text: firstText, fontWeight: FontWeight.bold),
      Txt(text: secondText,)
    ],
  );
}

Widget detailsPageTextEnd(String firstText, String secondText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Txt(text: firstText, fontWeight: FontWeight.bold),
      Txt(text: secondText)
    ],
  );
}