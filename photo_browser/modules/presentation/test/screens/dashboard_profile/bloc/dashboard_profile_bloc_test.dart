import 'package:bloc_test/bloc_test.dart';
import 'package:domain/usecase/get_local_user_usecase.dart';
import 'package:domain/usecase/get_local_users_usecase.dart';
import 'package:domain/usecase/update_local_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/dashboard_profile/bloc/dashboard_profile_bloc.dart';
import 'package:presentation/screens/dashboard_profile/dashboard_profile_argument.dart';

class MockGetLocalUserUsecase extends Mock implements GetLocalUserUsecase {}

class MockGetLocalUsersUsecase extends Mock implements GetLocalUsersUsecase {}

class MockUpdateLocalUserUsecase extends Mock implements UpdateLocalUserUsecase {}

void main() {
  late DashboardProfileBloc bloc;
  late MockGetLocalUserUsecase mockGetLocalUserUsecase;
  late MockGetLocalUsersUsecase mockGetLocalUsersUsecase;
  late MockUpdateLocalUserUsecase mockUpdateLocalUserUsecase;

  const argument = DashboardProfileArgument();

  setUp(
    () {
      mockGetLocalUserUsecase = MockGetLocalUserUsecase();
      mockGetLocalUsersUsecase = MockGetLocalUsersUsecase();
      mockUpdateLocalUserUsecase = MockUpdateLocalUserUsecase();
      bloc = DashboardProfileBloc(
        argument: argument,
        getLocalUserUsecase: mockGetLocalUserUsecase,
        getLocalUsersUsecase: mockGetLocalUsersUsecase,
        updateLocalUserUsecase: mockUpdateLocalUserUsecase,
      );
    },
  );

  blocTest<DashboardProfileBloc, DashboardProfileState>(
    'on DashboardProfileEvent.onInitiated emits nothing',
    build: () => bloc,
    act: (bloc) => bloc.add(const DashboardProfileEvent.onInitiated()),
    expect: () => [],
  );
}
