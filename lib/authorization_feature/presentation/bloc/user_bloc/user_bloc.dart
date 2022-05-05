import 'package:authorization_test_project/authorization_feature/domain/entities/user_entity.dart';
import 'package:authorization_test_project/authorization_feature/domain/repositories/user_reposithory.dart';
import 'package:authorization_test_project/core/error/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  static const serverErrorMessage = 'Server Error!';
  static const unidentifiedErrorMessage = 'Unidentified Error!';

  final emptyUser = const UserEntity(login: '', password: '');

  final UserReposithory userReposithory;

  late UserEntity user;

  UserBloc({required this.userReposithory}) : super(UserInitial()) {
    user = emptyUser;

    on<UpdateUserEvent>(_updateUser);
    on<GoStartStateEvent>(_goStartState);
    // on<ClearFormEvent>(_clearForm);
    // on<InvertPasswordVisableEvent>(_invertPasswordVisable);
    on<LogInEvent>(_logIn);
    on<CreateNewAccountEvent>(_createNewAccount);
    on<ChangePasswordEvent>(_changePassword);
  }

  void _updateUser(UpdateUserEvent event, Emitter<UserState> emit) {
    user = event.user;
  }

  void _goStartState(GoStartStateEvent event, Emitter<UserState> emit) {
    user = emptyUser;
    emit(UserInitial());
  }

  // void _clearForm(ClearFormEvent event, Emitter<UserState> emit) {
  //   emit(EmptyFormState());
  // }

  // void _invertPasswordVisable(
  //     InvertPasswordVisableEvent event, Emitter<UserState> emit) {
  //   final bool result = !event.isVisable;
  //   emit(PasswordVisableState(result));
  // }

  Future<void> _logIn(LogInEvent event, Emitter<UserState> emit) async {
    emit(LogInInProgressState());
    bool result = false;

    try {
      result = await userReposithory.isExisting(user);
    } catch (e) {
      emit(const LogInErrorState(serverErrorMessage));
    }

    if (result) {
      emit(LogInCompletedState());
    } else {
      emit(const LogInErrorState('This user does not exist'));
    }
  }

  Future<void> _createNewAccount(
      CreateNewAccountEvent event, Emitter<UserState> emit) async {
    emit(NewAccountInProgressState());
    try {
      await userReposithory.save(user);
      emit(NewAccountCompletedState());
    } catch (e) {
      if (e is Failure) {
        emit(NewAccountErrorState(e.message));
      } else {
        emit(const NewAccountErrorState(unidentifiedErrorMessage));
      }
    }
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<UserState> emit) async {
    emit(ChangePasswordInProgressState());
    try {
      await userReposithory.update(user);
      emit(ChangePasswordCompletedState());
    } catch (e) {
      if (e is Failure) {
        emit(ChangePasswordErrorState(e.message));
      } else {
        emit(const ChangePasswordErrorState(unidentifiedErrorMessage));
      }
    }
  }
}
