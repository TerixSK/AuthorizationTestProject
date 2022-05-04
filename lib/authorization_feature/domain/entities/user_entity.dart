import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final String password;

  const UserEntity({required this.login, required this.password});

  @override
  List<Object?> get props => [
        login,
        password,
      ];
}
