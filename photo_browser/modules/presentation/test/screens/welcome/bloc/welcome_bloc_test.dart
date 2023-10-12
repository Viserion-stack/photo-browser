import 'package:bloc_test/bloc_test.dart';
import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_local_users_usecase.dart';
import 'package:domain/usecase/register_local_user_usecase.dart';
import 'package:domain/usecase/update_local_user_usecase.dart';
import 'package:domain/user_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/login_argument.dart';

class MockUserProvider extends Mock implements UserProvider {}

class MockGetLocalUsersUsecase extends Mock implements GetLocalUsersUsecase {}

class MockRegisterLocalUserUsecase extends Mock implements RegisterLocalUserUsecase {}

void main() {
  late MockUserProvider mockUserProvider;
  late MockGetLocalUsersUsecase mockGetLocalUsersUsecase;
  late MockRegisterLocalUserUsecase mockRegisterLocalUserUsecase;
  late LoginBloc bloc;

  const argument = LoginArgument();
  final user = User.initial();

  setUp(
    () {
      mockUserProvider = MockUserProvider();
      mockGetLocalUsersUsecase = MockGetLocalUsersUsecase();
      mockRegisterLocalUserUsecase = MockRegisterLocalUserUsecase();
      bloc = LoginBloc(
        argument: argument,
        userProvider: mockUserProvider,
        localUsers: mockGetLocalUsersUsecase,
        registerLocalUser: mockRegisterLocalUserUsecase,
      );
    },
  );

  blocTest<LoginBloc, LoginState>(
    'on LoginEvent.onInitiated emits nothing',
    build: () => bloc,
    act: (bloc) => bloc.add(const LoginEvent.onInitiated()),
    expect: () => [],
  );

  blocTest<LoginBloc, LoginState>(
    'on LoginEvent.onLoggedIn emits update of type '
    'when updating user returns UpdateLocalUserFailure.fatal error',
    build: () {
      when(() => mockUserProvider.updateUser(user)).thenAnswer((_) => TaskEither.left(UpdateLocalUserFailure.fatal));
      return bloc;
    },
    seed: () => LoginState.initial(argument: argument).copyWith(
      type: StateType.loaded,
    ),
    act: (bloc) => bloc.add(const LoginEvent.onLoggedIn()),
    expect: () => [
      LoginState.initial(argument: argument).copyWith(
        type: StateType.loading,
      ),
      LoginState.initial(argument: argument).copyWith(
        type: StateType.error,
      ),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'on LoginEvent.onLoggedIn emits update of type '
    'when updating user returns no error',
    build: () {
      when(() => mockUserProvider.updateUser(user)).thenAnswer((_) => TaskEither.right(unit));
      return bloc;
    },
    seed: () => LoginState.initial(argument: argument).copyWith(
      type: StateType.loaded,
    ),
    act: (bloc) => bloc.add(const LoginEvent.onLoggedIn()),
    expect: () => [
      LoginState.initial(argument: argument).copyWith(
        type: StateType.loading,
      ),
      LoginState.initial(argument: argument).copyWith(
        type: StateType.success,
      ),
    ],
  );
}
