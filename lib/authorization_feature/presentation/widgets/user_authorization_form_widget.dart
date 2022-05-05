import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAuthorizationFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const UserAuthorizationFormWidget({Key? key, required this.formKey})
      : super(key: key);

  @override
  State<UserAuthorizationFormWidget> createState() =>
      _UserAuthorizationFormWidgetState();
}

class _UserAuthorizationFormWidgetState
    extends State<UserAuthorizationFormWidget> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool isVisablePassword = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextFormField(
            controller: _emailTextController,
            autocorrect: false,
            validator: (email) {
              if (!isValidEmail(email ?? '')) {
                return 'The email must contain the "@" symbol and the domain name of the mail service.';
              }
            },
            onChanged: (_) => context
                .read<UserBloc>()
                .add(UpdateUserEvent(user: _makeUser())),
            decoration: InputDecoration(
                labelText: 'Email *',
                labelStyle: const TextStyle(color: AppColors.darkPurple),
                hintText: 'Enter your email',
                errorMaxLines: 2,
                prefixIcon: const Icon(Icons.alternate_email,
                    color: AppColors.darkPurple),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    _emailTextController.clear();
                  },
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder()),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordTextController,
            autocorrect: false,
            obscureText: !isVisablePassword,
            onChanged: (_) => context
                .read<UserBloc>()
                .add(UpdateUserEvent(user: _makeUser())),
            validator: (password) {
              if (!isValidPassword(password ?? '')) {
                return 'The password must consist of uppercase and lowercase letters, have numbers and be at least 8 characters.';
              }
            },
            decoration: InputDecoration(
                labelText: 'Password *',
                labelStyle: const TextStyle(color: AppColors.darkPurple),
                hintText: 'Enter your password',
                errorMaxLines: 3,
                prefixIcon:
                    const Icon(Icons.password, color: AppColors.darkPurple),
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.visibility, color: AppColors.darkPurple),
                  onPressed: () {
                    setState(() {
                      isVisablePassword = !isVisablePassword;
                    });
                  },
                ),
                enabledBorder: _enabledBorder(),
                focusedBorder: _focusedBorder()),
          ),
        ]),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]){8,}');
    return passwordRegExp.hasMatch(password);
  }

  // void _showErrorSnackBar() {
  //   Future.delayed(Duration.zero, () async {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Row(
  //         children: const [
  //           Icon(
  //             Icons.error,
  //             color: Colors.white,
  //             size: 24.0,
  //           ),
  //           SizedBox(width: 8.0),
  //           Text('Error occurred.'),
  //         ],
  //       ),
  //       backgroundColor: Colors.red,
  //       // duration: const Duration(seconds: 2),
  //       action: SnackBarAction(
  //         label: 'Try again!',
  //         textColor: Colors.white,
  //         onPressed: () => _clearTextField(),
  //       ),
  //     ));
  //   });
  // }

  // void _navigateToPrifile() {
  //   Future.delayed(Duration.zero, () async {
  //     final user = _makeUser();
  //     final route =
  //         MaterialPageRoute(builder: (context) => ProfilePage(user: user));
  //     await Navigator.push(context, route).then((_) => _clearTextField());
  //   });
  // }

  IconButton deleteIconButton(TextEditingController controller) {
    return IconButton(
      icon: const Icon(Icons.delete_outline, color: Colors.red),
      onPressed: () {
        controller.clear();
      },
    );
  }

  OutlineInputBorder _enabledBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: AppColors.darkPurple));
  }

  OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: AppColors.lightPurple));
  }

  // void _clearTextField() {
  //   _emailTextController.clear();
  //   _passwordTextController.clear();
  // }

  UserEntity _makeUser() {
    return UserEntity(
        login: _emailTextController.text,
        password: _passwordTextController.text);
  }
}
