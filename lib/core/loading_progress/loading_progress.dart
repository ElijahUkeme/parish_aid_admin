import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class ProgressDialog {
  static Widget threeDots({Color? color}) {
    return SizedBox(
      width: 50,
      child: SpinKitThreeBounce(
        size: 30.0,
        itemBuilder: (context, index) {
          return Align(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          );
        },
      ),
    );
  }

  static Widget imageLoadingShimmer({BoxShape? shape}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade300),
      ),
    );
  }
}
