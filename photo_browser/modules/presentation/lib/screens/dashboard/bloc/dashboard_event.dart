part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.onInitiated() = _OnInitiated;
  const factory DashboardEvent.hideBottomMenu() = _OnHideBottomMenu;
  const factory DashboardEvent.showBottomMenu() = _OnShowBottomMenu;
}
