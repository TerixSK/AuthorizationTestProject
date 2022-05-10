import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/pages/new_account_page.dart';
import 'package:authorization_test_project/authorization_feature/presentation/pages/profile_page.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_button_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_error_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/card_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/progress_idecator_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/user_authorization_form_widget.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:authorization_test_project/common/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

import 'change_password_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.defaultAppBar('Authorization'),
      body: Container(
        color: AppColors.lightPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: AppStyles.header,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is LogInCompletedState) {
                  _navigateToPrifile(context);
                } else if (state is LogInInProgressState) {
                  return const ProgressIndecatorWidget();
                } else if (state is LogInErrorState) {
                  return AuthorizationErrorWidget(text: state.message);
                }
                return CardWidget(
                  child: Column(
                    children: [
                      UserAuthorizationFormWidget(formKey: formKey),
                      const SizedBox(height: 30.0),
                      AuthorizationButtonWidget(
                          text: 'Create new account',
                          onPressed: () =>
                              _navigateTo(context, NewAccountPage())),
                      const SizedBox(height: 8.0),
                      AuthorizationButtonWidget(
                        text: 'Change password',
                        onPressed: () =>
                            _navigateTo(context, ChangePasswordPage()),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          child: const Text('Log in', style: AppStyles.whiteText),
          backgroundColor: AppColors.purple,
          onPressed: () {
            final formIsValid = formKey.currentState?.validate() ?? false;
            if (formIsValid) {
              context.read<UserBloc>().add(LogInEvent());
            }
          }),
    );
  }

  void _navigateTo(BuildContext context, StatelessWidget page) {
    final route = MaterialPageRoute(builder: (context) => page);
    Navigator.push(context, route);
  }

  void _navigateToPrifile(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      final user = context.read<UserBloc>().user;
      _navigateTo(context, ProfilePage(user: user));
    });
  }
}
