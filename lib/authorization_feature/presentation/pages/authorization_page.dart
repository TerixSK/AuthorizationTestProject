import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/user_authorization_form_widget.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:authorization_test_project/common/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.defaultAppBar('Authorization'),
      body: Container(
        color: AppColors.lightPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Welcome',
              style: AppStyles.header,
            ),
            UserAuthorizationFormWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          child: const Text('Log in', style: AppStyles.text),
          backgroundColor: AppColors.purple,
          onPressed: () => context.read<UserBloc>().add(LogInEvent())),
    );
  }
}
