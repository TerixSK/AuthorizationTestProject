import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:authorization_test_project/authorization_feature/presentation/pages/profile_page.dart';
import 'package:authorization_test_project/authorization_feature/presentation/widgets/progress_idecator_widget.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authorization_button_widget.dart';

class UserAuthorizationFormWidget extends StatefulWidget {
  const UserAuthorizationFormWidget({Key? key}) : super(key: key);

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
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is CompletedState) {
          _navigateToPrifile();
        } else if (state is ErrorState) {
          _showErrorSnackBar();
        } else if (state is InProgressState) {
          return const ProgressIndecatorWidget();
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, bottom: 128.0, top: 32.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 32.0),
                  child: Column(children: [
                    TextFormField(
                      controller: _emailTextController,
                      autocorrect: false,
                      onChanged: (_) => context
                          .read<UserBloc>()
                          .add(UpdateUserEvent(user: _makeUser())),
                      decoration: InputDecoration(
                          labelText: 'Email *',
                          labelStyle:
                              const TextStyle(color: AppColors.darkPurple),
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(Icons.email,
                              color: AppColors.darkPurple),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.red),
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
                      decoration: InputDecoration(
                          labelText: 'Password *',
                          labelStyle:
                              const TextStyle(color: AppColors.darkPurple),
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.password,
                              color: AppColors.darkPurple),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility,
                                color: AppColors.darkPurple),
                            onPressed: () {
                              setState(() {
                                isVisablePassword = !isVisablePassword;
                              });
                            },
                          ),
                          enabledBorder: _enabledBorder(),
                          focusedBorder: _focusedBorder()),
                    ),
                    const SizedBox(height: 30),
                    AuthorizationButtonWidget(
                      text: 'Create new account',
                      onPressed: () =>
                          context.read<UserBloc>().add(NewAccountEvent()),
                    ),
                    const SizedBox(height: 8),
                    AuthorizationButtonWidget(
                      text: 'Change password',
                      onPressed: () =>
                          context.read<UserBloc>().add(ChangePasswordEvent()),
                    )
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showErrorSnackBar() {
    Future.delayed(Duration.zero, () async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: const [
            Icon(
              Icons.error,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(width: 8.0),
            Text('Error occurred.'),
          ],
        ),
        backgroundColor: Colors.red,
        // duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Try again!',
          textColor: Colors.white,
          onPressed: () => _clearTextField(),
        ),
      ));
    });
  }

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

  void _clearTextField() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }

  void _navigateToPrifile() {
    Future.delayed(Duration.zero, () async {
      final user = _makeUser();
      final route =
          MaterialPageRoute(builder: (context) => ProfilePage(user: user));
      await Navigator.push(context, route).then((_) => _clearTextField());
    });
  }

  UserEntity _makeUser() {
    return UserEntity(
        login: _emailTextController.text,
        password: _passwordTextController.text);
  }
}
