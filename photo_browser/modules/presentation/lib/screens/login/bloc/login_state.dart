part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required StateType type,
    required LoginArgument argument,
    required bool isLoginOpened,
    required bool isAnimationEnd,
    required NameFormz nameFormz,
    required EmailFormz emailFormz,
    required PasswordFormz passwordFormz,
    required LoginPasswordFormz loginPasswordFormz,
    required LoginStatus loginStatus,
  }) = _LoginState;

  const LoginState._();

  factory LoginState.initial({required LoginArgument argument}) => LoginState(
        type: StateType.initial,
        argument: argument,
        isLoginOpened: true,
        isAnimationEnd: true,
        nameFormz: const NameFormz.pure(),
        emailFormz: const EmailFormz.pure(),
        passwordFormz: const PasswordFormz.pure(),
        loginPasswordFormz: const LoginPasswordFormz.pure(),
        loginStatus: LoginStatus.none,
      );

  bool get isEmailAndPasswordValidated => emailFormz.isValid && loginPasswordFormz.isValid;
  bool get isRegisterFormValidated => emailFormz.isValid && nameFormz.isValid && passwordFormz.isValid;
}
