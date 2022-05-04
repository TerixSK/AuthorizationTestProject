part of 'user_bloc.dart';

abstract class UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  UpdateUserEvent({required this.user});
}

class LogInEvent extends UserEvent {}

class NewAccountEvent extends UserEvent {}

class ChangePasswordEvent extends UserEvent {}
