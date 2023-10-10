part of 'dashboard_profile_bloc.dart';

@freezed
class DashboardProfileEvent with _$DashboardProfileEvent {
  const factory DashboardProfileEvent.onInitiated() = _OnInitiated;
  const factory DashboardProfileEvent.onSelectedProfileImage({required String imagePath}) = _OnSelectedProfileImage;
}
