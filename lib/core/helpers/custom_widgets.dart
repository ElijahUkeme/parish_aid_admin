
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:parish_aid_admin/core/helpers/widget.dart';

import '../utils/color.dart';
import 'button.dart';



void pp(Object? object) {
  if (kDebugMode) {
    final logger = Logger();
    logger.d(object);
  }
}
Widget shareButton() {
  return Expanded(
      child: Button(
        text: 'Share',
        processingText: 'Sharing...',
        textColor: Colorz.interlacedChatPurple,
        buttonColor: Colorz.interlacedChatPurple.withOpacity(0.1),
        onPressed: shareFn,
      ));
}
Future<void> shareFn() async {
  await Widgets.wait(3000);
}
