import 'dart:async';
import 'dart:developer';

import 'package:authorization_test_project/authorization_feature/data/datasources/user_local_datasource.dart';
import 'package:authorization_test_project/authorization_feature/data/exception/exception.dart';
import 'package:authorization_test_project/authorization_feature/data/models/user_model.dart';
import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/authorization_feature/domain/repositories/user_reposithory.dart';

class UserReposithoryImpl implements UserReposithory {
  final UserLocalDataSource localDataSource;

  UserReposithoryImpl({required this.localDataSource});

  @override
  Future<void> save(UserEntity user) async {
    try {
      final UserModel model = _mapEntityToModel(user);
      await serverDelay();
      await localDataSource.save(model);
    } catch (e) {
      _exceptionHandler(e);
    }
  }

  @override
  Future<void> update(UserEntity user) async {
    try {
      final UserModel model = _mapEntityToModel(user);
      await serverDelay();
      localDataSource.update(model);
    } catch (e) {
      _exceptionHandler(e);
    }
  }

  @override
  Future<bool> isExisting(UserEntity user) async {
    try {
      final UserModel model = _mapEntityToModel(user);
      await serverDelay();
      return localDataSource.isExisting(model);
    } catch (e) {
      _exceptionHandler(e);
    }

    return false;
  }

  Future<void> serverDelay() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  UserModel _mapEntityToModel(UserEntity user) {
    return UserModel(login: user.login, password: user.password);
  }

  void _exceptionHandler(Object e) {
    if (e.runtimeType is DatabaseException) {
      log('database error has occurred');
    } else if (e.runtimeType is OperationException) {
      log('operation error has occurred');
    } else {
      log('unidentified error has occurred');
    }
  }
}
