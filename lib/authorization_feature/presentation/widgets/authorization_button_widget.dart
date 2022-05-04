import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:flutter/material.dart';

class AuthorizationButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AuthorizationButtonWidget(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.purple)),
        child: Container(
          width: 250.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: AppStyles.text,
                ),
                const SizedBox(width: 4.0),
                const Icon(Icons.arrow_forward_rounded, size: 24.0),
              ],
            ),
          ),
        ));
  }
}
