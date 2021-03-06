import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:authorization_test_project/common/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.defaultAppBar('Profile'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Information about your profile:',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple),
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spring.bubbleButton(
                  animDuration: const Duration(milliseconds: 1500),
                  child: Image.asset(
                    'assets/images/profile.jpeg',
                    width: 300,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                _makeUserInfoText('Email: ' + user.login, AppColors.purple),
                const SizedBox(
                  height: 8.0,
                ),
                _makeUserInfoText(
                    'Password: ' + user.password, AppColors.purple),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        child: const Text('Log out', style: AppStyles.whiteText),
        backgroundColor: AppColors.purple,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Text _makeUserInfoText(String text, Color textColor) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w400, color: textColor),
    );
  }
}
