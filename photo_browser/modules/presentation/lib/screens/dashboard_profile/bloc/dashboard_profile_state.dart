part of 'dashboard_profile_bloc.dart';

@freezed
class DashboardProfileState with _$DashboardProfileState {
  const factory DashboardProfileState({
    required StateType type,
    required DashboardProfileArgument argument,
    required String profileImagePath,
    required User user,
  }) = _DashboardProfileState;

  factory DashboardProfileState.initial({required DashboardProfileArgument argument}) {
    return DashboardProfileState(
      type: StateType.loading,
      profileImagePath: '',
      argument: argument,
      user: User.initial(),
    );
  }
}
