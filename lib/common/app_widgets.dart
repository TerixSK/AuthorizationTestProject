import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:flutter/material.dart';

class AppWidgets {
  static defaultAppBar(String title) => AppBar(
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 32.0, color: Colors.white, fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkPurple,
      );
}
