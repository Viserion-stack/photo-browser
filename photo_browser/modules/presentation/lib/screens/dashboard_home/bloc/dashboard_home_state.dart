part of 'dashboard_home_bloc.dart';

@freezed
class DashboardHomeState with _$DashboardHomeState {
  const factory DashboardHomeState({
    required StateType type,
    required DashboardHomeArgument argument,
    required List<Photo> photo,
  }) = _DashboardHomeState;

  factory DashboardHomeState.initial({required DashboardHomeArgument argument}) {
    return DashboardHomeState(
      type: StateType.loading,
      argument: argument,
      photo: [Photo.initial()],
    );
  }
}
