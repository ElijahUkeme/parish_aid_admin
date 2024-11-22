
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';
import '../utils/color.dart';

class SmallEmptyList extends StatelessWidget {
  const SmallEmptyList({super.key, required this.title, this.iconData});
  final IconData? iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 100,
          child: CircleAvatar(
            backgroundColor:
            kColor20, // backgroundColor ?? AppColor.kGhostWhite,
            radius: 50,
            child: Icon(
              iconData ?? Icons.no_accounts,
              size: 48.0,
              color: Colors.brown.withOpacity(0.5),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.body1.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
