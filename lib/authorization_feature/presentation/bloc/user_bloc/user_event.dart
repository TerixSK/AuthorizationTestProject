part of 'user_bloc.dart';

abstract class UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  UpdateUserEvent({required this.user});
}

// class ClearFormEvent extends UserEvent {}

// class InvertPasswordVisableEvent extends UserEvent {
//   final bool isVisable;

//   InvertPasswordVisableEvent(this.isVisable);
// }

class GoStartStateEvent extends UserEvent {}

class LogInEvent extends UserEvent {}

class CreateNewAccountEvent extends UserEvent {}

class ChangePasswordEvent extends UserEvent {}
