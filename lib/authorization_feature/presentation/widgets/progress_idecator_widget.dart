import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressIndecatorWidget extends StatelessWidget {
  const ProgressIndecatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 48.0, bottom: 100.0),
      child: SpinKitDoubleBounce(
        color: AppColors.purple,
        size: 100.0,
      ),
    );
  }
}
