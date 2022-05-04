import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:authorization_test_project/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authorization_feature/locator_service.dart' as di;
import 'authorization_feature/locator_service.dart';
import 'authorization_feature/presentation/pages/authorization_page.dart';

Future<void> main() async {
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => sl<UserBloc>()),
      ],
      child: MaterialApp(
        title: 'Authorization Test Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: AppColors.purple),
        home: const AuthorizationPage(),
      ),
    );
  }
}
