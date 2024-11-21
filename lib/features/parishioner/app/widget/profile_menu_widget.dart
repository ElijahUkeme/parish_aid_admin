
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parish_aid_admin/features/home/app/widgets/details_page_widget.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.firstTitle,
    required this.firstText,
    required this.secondTitle,
    required this.secondText,
    this.textColor,
  }) : super(key: key);

  final String firstTitle;
  final String firstText;
  final String secondTitle;
  final String secondText;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.blue : Colors.accents;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        detailsPageTextStart(firstTitle, firstText),
        detailsPageTextEnd(secondTitle, secondText)

      ],
    );
  }
}