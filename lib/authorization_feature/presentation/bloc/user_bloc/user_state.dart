part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);
}

class LogInCompletedState extends UserState {}

class LogInInProgressState extends UserState {}

class LogInErrorState extends UserErrorState {
  const LogInErrorState(String message) : super(message);
}

class NewAccountCompletedState extends UserState {}

class NewAccountInProgressState extends UserState {}

class NewAccountErrorState extends UserErrorState {
  const NewAccountErrorState(String message) : super(message);
}

class ChangePasswordCompletedState extends UserState {}

class ChangePasswordInProgressState extends UserState {}

class ChangePasswordErrorState extends UserErrorState {
  const ChangePasswordErrorState(String message) : super(message);
}

// class EmptyFormState extends UserState {}

// class PasswordVisableState extends UserState {
//   final bool isVisable;

//   const PasswordVisableState(this.isVisable);
// }
