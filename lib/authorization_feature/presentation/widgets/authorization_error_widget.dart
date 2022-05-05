import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/authorization_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'card_widget.dart';

class AuthorizationErrorWidget extends StatelessWidget {
  final String text;

  const AuthorizationErrorWidget({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Image.asset(
                'assets/images/error.jpeg',
                width: 280.0,
              ),
            ),
            AuthorizationButtonWidget(
                text: 'Try Again!',
                onPressed: () =>
                    context.read<UserBloc>().add(GoStartStateEvent()))
          ],
        ),
      ),
    );
  }
}
