import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';

abstract class UserReposithory {
  Future<void> save(UserEntity user);

  Future<void> update(UserEntity user);

  Future<bool> isExisting(UserEntity user);
}
