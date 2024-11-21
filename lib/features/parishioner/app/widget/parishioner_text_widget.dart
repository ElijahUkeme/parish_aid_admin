import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_dimensions.dart';
import '../../../../core/utils/app_styles.dart';

Widget parishionerTextWidget(String title,String text){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        title,
        style: TextStyles.body2
            .copyWith(color: Colors.blueGrey),
      ),
      //horizontal spacer,
      Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.end,
                softWrap: true,
                style: TextStyles.h5.copyWith(
                  fontSize: FontSizes.s13,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}