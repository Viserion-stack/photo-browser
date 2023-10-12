import 'dart:async';

import 'package:collection/collection.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_local_users_usecase.dart';
import 'package:domain/usecase/register_local_user_usecase.dart';
import 'package:domain/user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/login_status.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/components/formz/email_formz.dart';
import 'package:presentation/components/formz/login_password_formz.dart';
import 'package:presentation/components/formz/name_formz.dart';
import 'package:presentation/components/formz/password_formz.dart';
import 'package:presentation/screens/login/login_argument.dart';

part 'login_bloc.freezed.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginArgument argument,
    required UserProvider userProvider,
    required GetLocalUsersUsecase localUsers,
    required RegisterLocalUserUsecase registerLocalUser,
  })  : _userProvider = userProvider,
        _localUsers = localUsers,
        _registerLocalUser = registerLocalUser,
        super(LoginState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_OnLoggedIn>(_onLoggedIn);
    on<_OnLoginOpened>(_onLoginOpened);
    on<_OnSignUpOpened>(_onSignUpOpened);
    on<_OnAnimationEnd>(_onAnimationEnd);
    on<_OnNameChanged>(_onNameChanged);
    on<_OnEmailChanged>(_onEmailChanged);
    on<_OnPasswordChanged>(_onPasswordChanged);
    on<_OnRegisterSubmited>(_onRegisterSubmited);
    on<_OnLoginPasswordChanged>(_onLoginPasswordChanged);
  }

  final UserProvider _userProvider;
  final GetLocalUsersUsecase _localUsers;
  final RegisterLocalUserUsecase _registerLocalUser;

  User? user;

  Future<void> _onInitiated(_OnInitiated event, Emitter<LoginState> emit) async {}

  Future<void> _onLoggedIn(_OnLoggedIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(type: StateType.loading));

    if (state.isEmailAndPasswordValidated) {
      await _localUsers.execute().match(
        (_) => emit(state.copyWith(type: StateType.error)),
        (users) {
          user = users.firstWhereOrNull((element) =>
              element.email == state.emailFormz.value && element.password == state.loginPasswordFormz.value);
        },
      ).run();

      if (user != null) {
        await Future.delayed(const Duration(seconds: 1));

        final result = await _userProvider
            .updateUser(user!)
            .match(
              (_) => state.copyWith(type: StateType.error),
              (_) => state.copyWith(
                type: StateType.success,
              ),
            )
            .run();

        return emit(result);
      } else {
        return emit(
          state.copyWith(
            type: StateType.loaded,
            loginStatus: LoginStatus.userNotExist,
          ),
        );
      }
    }

    return emit(
      state.copyWith(
        type: StateType.loaded,
        loginStatus: LoginStatus.incorrectEmailOrPassword,
      ),
    );
  }

  Future<void> _onLoginOpened(_OnLoginOpened event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isLoginOpened: true,
        isAnimationEnd: false,
        nameFormz: const NameFormz.pure(),
      ),
    );
  }

  Future<void> _onSignUpOpened(_OnSignUpOpened event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isLoginOpened: false,
        isAnimationEnd: false,
        nameFormz: const NameFormz.pure(),
      ),
    );
  }

  Future<void> _onAnimationEnd(_OnAnimationEnd event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isAnimationEnd: true));
  }

  Future<void> _onNameChanged(_OnNameChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        nameFormz: NameFormz.dirty(value: event.name),
      ),
    );
  }

  Future<void> _onEmailChanged(_OnEmailChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        emailFormz: EmailFormz.dirty(value: event.email),
      ),
    );
  }

  Future<void> _onPasswordChanged(_OnPasswordChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        passwordFormz: PasswordFormz.dirty(value: event.password),
      ),
    );
  }

  Future<void> _onRegisterSubmited(_OnRegisterSubmited event, Emitter<LoginState> emit) async {
    if (state.isRegisterFormValidated) {
      final user = User(
        name: state.nameFormz.value,
        email: state.emailFormz.value,
        password: state.passwordFormz.value,
      );

      await _registerLocalUser.execute(param: user).match(
        (_) => emit(state.copyWith(type: StateType.error)),
        (isRegistered) {
          if (isRegistered) {
            emit(
              state.copyWith(
                loginStatus: LoginStatus.registered,
                isLoginOpened: true,
                emailFormz: const EmailFormz.pure(),
                passwordFormz: const PasswordFormz.pure(),
                nameFormz: const NameFormz.pure(),
              ),
            );
          } else {
            emit(
              state.copyWith(type: StateType.error),
            );
          }
        },
      ).run();
    } else {
      emit(
        state.copyWith(type: StateType.error),
      );
    }
  }

  Future<void> _onLoginPasswordChanged(_OnLoginPasswordChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        loginPasswordFormz: LoginPasswordFormz.dirty(value: event.loginPassword),
      ),
    );
  }
}
