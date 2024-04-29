import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

class AuthErrorWidget extends StatelessWidget {
  final Function()? onTap;
  final String? errorText;

  const AuthErrorWidget({Key? key, this.errorText, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15.0, top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorText!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: InkWell(
                  child: const Icon(
                    Icons.refresh,
                    color: AppColor.primaryColor,
                  ),
                  onTap: () {
                    onTap!();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
