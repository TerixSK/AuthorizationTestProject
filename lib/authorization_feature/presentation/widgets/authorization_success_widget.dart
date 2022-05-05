import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_button_widget.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'card_widget.dart';

class AuthorizationSuccessWidget extends StatelessWidget {
  final String text;

  const AuthorizationSuccessWidget({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.task_alt,
              size: 50.0,
              color: AppColors.purple,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: AppColors.purple,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            ),
            AuthorizationButtonWidget(
                text: 'Go to log in page',
                onPressed: () {
                  Navigator.pop(context);
                  context.read<UserBloc>().add(GoStartStateEvent());
                })
          ],
        ),
      ),
    );
  }
}
