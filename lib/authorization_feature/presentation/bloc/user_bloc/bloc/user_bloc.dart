import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/authorization_feature/domain/repositories/user_reposithory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserReposithory userReposithory;

  late UserEntity user;

  UserBloc({required this.userReposithory}) : super(UserInitial()) {
    user = const UserEntity(login: '', password: '');

    on<UpdateUserEvent>(_updateUser);
    on<LogInEvent>(_logIn);
    on<NewAccountEvent>(_createNewAccount);
    on<ChangePasswordEvent>(_changePassword);
  }

  void _updateUser(UpdateUserEvent event, Emitter<UserState> emit) {
    user = event.user;
  }

  Future<void> _logIn(LogInEvent event, Emitter<UserState> emit) async {
    emit(InProgressState());
    final result = await userReposithory.isExisting(user);
    if (result) {
      emit(CompletedState());
    } else {
      emit(ErrorState());
    }
  }

  Future<void> _createNewAccount(
      NewAccountEvent event, Emitter<UserState> emit) async {
    emit(InProgressState());
    try {
      await userReposithory.save(user);
      emit(CompletedState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(InProgressState());
    try {
      await userReposithory.update(user);
      emit(CompletedState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
