import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:flutter/material.dart';

// import 'user_authorization_form_widget.dart';

enum AuthorizationMode { start, createNewAccount, changePassword }

class AuthorizationBottomSheetWidget {
  AuthorizationBottomSheetWidget(AuthorizationMode mode, BuildContext context) {
    _showBottomSheet(mode, context);
  }

  void _showBottomSheet(AuthorizationMode mode, BuildContext context) {
    String text = '';
    if (mode == AuthorizationMode.createNewAccount) {
      text = 'Enter your email and password to create a new account';
    } else if (mode == AuthorizationMode.changePassword) {
      text = 'Enter your email and a new password to change user data.';
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 550,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: AppStyles.text,
                    ),
                  ),
                  // UserAuthorizationFormWidget(mode: mode)
                ],
              ),
            ),
          );
        });
  }
}
