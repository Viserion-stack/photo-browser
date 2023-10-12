part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onInitiated() = _OnInitiated;
  const factory LoginEvent.onLoggedIn() = _OnLoggedIn;
  const factory LoginEvent.onLoginOpened() = _OnLoginOpened;
  const factory LoginEvent.onSignUpOpened() = _OnSignUpOpened;
  const factory LoginEvent.onAnimationEnd() = _OnAnimationEnd;
  const factory LoginEvent.onPasswordChanged(String password) = _OnPasswordChanged;
  const factory LoginEvent.onNameChanged(String name) = _OnNameChanged;
  const factory LoginEvent.onEmailChanged(String email) = _OnEmailChanged;
  const factory LoginEvent.onLoginPasswordChanged(String loginPassword) = _OnLoginPasswordChanged;
  const factory LoginEvent.onRegisterSubmited() = _OnRegisterSubmited;
}
