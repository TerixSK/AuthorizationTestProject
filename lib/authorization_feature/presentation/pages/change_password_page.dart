import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_error_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_success_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/card_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/progress_idecator_widget.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/user_authorization_form_widget.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:authorization_test_project/common/app_styles.dart';
import 'package:authorization_test_project/common/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidgets.defaultAppBar('Authorization', withBackButton: true),
      body: Container(
        color: AppColors.lightPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Change Password',
              textAlign: TextAlign.center,
              style: AppStyles.header,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is ChangePasswordCompletedState) {
                  return const AuthorizationSuccessWidget(
                      text:
                          'Congratulations! Your account password has been changed.');
                } else if (state is ChangePasswordInProgressState) {
                  return const ProgressIndecatorWidget();
                } else if (state is ChangePasswordErrorState) {
                  return AuthorizationErrorWidget(text: state.message);
                }
                return CardWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Enter your OLD email and NEW password to change your account password.',
                          style: AppStyles.purpleText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      UserAuthorizationFormWidget(formKey: formKey),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.update),
          backgroundColor: AppColors.purple,
          onPressed: () {
            final formIsValid = formKey.currentState?.validate() ?? false;
            if (formIsValid) {
              context.read<UserBloc>().add(ChangePasswordEvent());
            }
          }),
    );
  }
}
