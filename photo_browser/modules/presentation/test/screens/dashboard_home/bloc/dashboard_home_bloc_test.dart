import 'package:bloc_test/bloc_test.dart';
import 'package:domain/usecase/get_photo_usecase.dart';
import 'package:domain/usecase/get_user_usecase.dart';
import 'package:domain/usecase/search_photos_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/dashboard_home/bloc/dashboard_home_bloc.dart';
import 'package:presentation/screens/dashboard_home/dashboard_home_argument.dart';

class MockGetPhotoUsecase extends Mock implements GetPhotoUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockSearchPhotosUsecase extends Mock implements SearchPhotosUsecase {}

void main() {
  late DashboardHomeBloc bloc;
  late MockGetPhotoUsecase mockGetPhotoUsecase;
  late MockGetUserUsecase mockGetUserUsecase;
  late MockSearchPhotosUsecase mockSearchPhotosUsecase;

  const argument = DashboardHomeArgument();

  setUp(
    () {
      mockGetPhotoUsecase = MockGetPhotoUsecase();
      mockGetUserUsecase = MockGetUserUsecase();
      mockSearchPhotosUsecase = MockSearchPhotosUsecase();
      bloc = DashboardHomeBloc(
        argument: argument,
        getPhotoUsecase: mockGetPhotoUsecase,
        getUserUsecase: mockGetUserUsecase,
        searchPhotosUsecase: mockSearchPhotosUsecase,
      );
    },
  );

  blocTest<DashboardHomeBloc, DashboardHomeState>(
    'on DashboardHomeEvent.onInitiated emits nothing',
    build: () => bloc,
    act: (bloc) => bloc.add(const DashboardHomeEvent.onInitiated()),
    expect: () => [],
  );
}
