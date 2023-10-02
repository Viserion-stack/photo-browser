part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required StateType type,
    required LoginArgument argument,
    required bool isLoginOpened,
    required bool isAnimationEnd,
  }) = _LoginState;

  factory LoginState.initial({required LoginArgument argument}) {
    return LoginState(
      type: StateType.initial,
      argument: argument,
      isLoginOpened: true,
      isAnimationEnd: true,
    );
  }
}
