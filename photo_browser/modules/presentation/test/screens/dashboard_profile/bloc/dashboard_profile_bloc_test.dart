import 'package:bloc_test/bloc_test.dart';
import 'package:domain/usecase/get_local_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/screens/dashboard_profile/bloc/dashboard_profile_bloc.dart';
import 'package:presentation/screens/dashboard_profile/dashboard_profile_argument.dart';

class MockGetLocalUserUsecase extends Mock implements GetLocalUserUsecase {}

void main() {
  late DashboardProfileBloc bloc;
  late MockGetLocalUserUsecase mockGetLocalUserUsecase;

  const argument = DashboardProfileArgument();

  setUp(
    () {
      mockGetLocalUserUsecase = MockGetLocalUserUsecase();

      bloc = DashboardProfileBloc(
        argument: argument,
        getLocalUserUsecase: mockGetLocalUserUsecase,
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
