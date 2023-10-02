import 'dart:async';

import 'package:domain/model/user.dart';
import 'package:domain/user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/login/login_argument.dart';

part 'login_bloc.freezed.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginArgument argument,
    required UserProvider userProvider,
  })  : _userProvider = userProvider,
        super(LoginState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_OnLoggedIn>(_onLoggedIn);
    on<_OnLoginOpened>(_onLoginOpened);
    on<_OnSignUpOpened>(_onSignUpOpened);
    on<_OnAnimationEnd>(_onAnimationEnd);
  }

  final UserProvider _userProvider;

  Future<void> _onInitiated(_OnInitiated event, Emitter<LoginState> emit) async {}

  Future<void> _onLoggedIn(_OnLoggedIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(type: StateType.loading));

    final user = User.initial();
    final newState = await _userProvider
        .updateUser(user)
        .match(
          (_) => state.copyWith(type: StateType.error),
          (_) => state.copyWith(type: StateType.success),
        )
        .run();

    emit(newState);
  }

  Future<void> _onLoginOpened(_OnLoginOpened event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isLoginOpened: true,
        isAnimationEnd: false,
      ),
    );
  }

  Future<void> _onSignUpOpened(_OnSignUpOpened event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isLoginOpened: false,
        isAnimationEnd: false,
      ),
    );
  }

  Future<void> _onAnimationEnd(_OnAnimationEnd event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isAnimationEnd: true));
  }
}
