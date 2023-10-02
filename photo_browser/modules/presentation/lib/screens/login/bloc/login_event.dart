part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onInitiated() = _OnInitiated;
  const factory LoginEvent.onLoggedIn() = _OnLoggedIn;
  const factory LoginEvent.onLoginOpened() = _OnLoginOpened;
  const factory LoginEvent.onSignUpOpened() = _OnSignUpOpened;
  const factory LoginEvent.onAnimationEnd() = _OnAnimationEnd;
}
