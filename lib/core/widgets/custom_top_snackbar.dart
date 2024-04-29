import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showCustomTopSnackBar(BuildContext context,
    {required String message, Color? color}) {
  showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: message,
        textStyle: GoogleFonts.montserrat(fontSize: 14, color: Colors.black),
        icon: Container(),
        backgroundColor: Colors.white70,
      ),
      animationDuration: const Duration(milliseconds: 1000));
}
