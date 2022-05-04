import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required login, required password})
      : super(login: login, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(login: json['login'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final resultMap = {'login': login, 'password': password};
    return resultMap;
  }
}
