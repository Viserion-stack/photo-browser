part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required StateType userStateType,
    required String userImage,
    User? user,
  }) = _AuthState;

  const AuthState._();

  factory AuthState.initial() => const AuthState(
        userStateType: StateType.initial,
        userImage: '',
      );

  bool get isLoggedIn => user != null;
}
