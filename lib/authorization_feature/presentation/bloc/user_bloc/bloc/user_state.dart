part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class CompletedState extends UserState {}

class InProgressState extends UserState {}

class ErrorState extends UserState {}
