import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';

class AppWidgets {
  static defaultAppBar(String title, {withBackButton = false}) => AppBar(
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 32.0, color: Colors.white, fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        automaticallyImplyLeading: withBackButton,
        backgroundColor: AppColors.darkPurple,
      );
}
