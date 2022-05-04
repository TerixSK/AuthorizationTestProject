import 'package:authorization_test_project/authorization_feature/data/datasources/user_local_datasource.dart';
import 'package:authorization_test_project/authorization_feature/data/repositories/user_reposithory_impl.dart';
import 'package:authorization_test_project/authorization_feature/domain/repositories/user_reposithory.dart';
import 'package:authorization_test_project/authorization_feature/presentation/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserBloc(userReposithory: sl()));

  sl.registerLazySingleton<UserReposithory>(
      () => UserReposithoryImpl(localDataSource: sl()));

  await Hive.initFlutter();
  final box = await Hive.openBox<String>(userBoxKey);
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSource(box: box));
}
