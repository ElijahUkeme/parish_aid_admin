
import 'package:flutter/cupertino.dart';
import 'package:parish_aid_admin/core/helpers/widget.dart';

import '../utils/color.dart';
import 'button.dart';

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
