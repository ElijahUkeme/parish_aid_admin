import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIcon extends StatelessWidget {
  final Color? color;
  final double? size;
  const LoadingIcon({Key? key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 25.0,
      height: size ?? 25.0,
      child: SpinKitRotatingCircle(
        color: color ?? Colors.white,
        size: 25,
      ),
    );
  }
}
