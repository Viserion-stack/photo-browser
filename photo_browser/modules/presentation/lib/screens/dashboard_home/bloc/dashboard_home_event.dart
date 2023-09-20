part of 'dashboard_home_bloc.dart';

@freezed
class DashboardHomeEvent with _$DashboardHomeEvent {
  const factory DashboardHomeEvent.onInitiated() = _OnInitiated;
  const factory DashboardHomeEvent.photosFetched() = _PhotosFetched;
  const factory DashboardHomeEvent.photosSearched({required String query}) = _PhotosSearched;
  const factory DashboardHomeEvent.loadMorePhotos() = _LoadedMorePhotos;
}
