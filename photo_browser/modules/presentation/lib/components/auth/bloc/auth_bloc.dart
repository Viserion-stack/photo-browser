import 'dart:async';

import 'package:domain/model/user.dart';
import 'package:domain/usecase/add_local_users_usecase.dart';
import 'package:domain/usecase/delete_user_usecase.dart';
import 'package:domain/usecase/get_local_users_usecase.dart';
import 'package:domain/usecase/update_local_user_usecase.dart';
import 'package:domain/user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required UserProvider userProvider,
    required GetLocalUsersUsecase getLocalUsersUsecase,
    required UpdateLocalUserUsecase updateLocalUserUsecase,
    required DeleteUserUsecase deleteUserUsecase,
    required AddLocalUsersUsecase addLocalUsersUsecase,
  })  : _userProvider = userProvider,
        _updateLocalUserUsecase = updateLocalUserUsecase,
        _getLocalUsersUsecase = getLocalUsersUsecase,
        _deleteUserUsecase = deleteUserUsecase,
        _addLocalUsersUsecase = addLocalUsersUsecase,
        super(AuthState.initial()) {
    on<_OnInitiated>(_onInitiated);
    on<_OnUserUpdated>(_onUserUpdated);
    on<_OnAuthCheckRequested>(_onAuthCheckRequested);
    on<_OnSignedOut>(_onSignedOut);
    on<_OnSelectedImge>(_onSelectedImage);
  }

  final UserProvider _userProvider;
  final UpdateLocalUserUsecase _updateLocalUserUsecase;
  final GetLocalUsersUsecase _getLocalUsersUsecase;
  final DeleteUserUsecase _deleteUserUsecase;
  final AddLocalUsersUsecase _addLocalUsersUsecase;

  StreamSubscription<User?>? _userStreamSubscription;

  User user = User.initial();
  List<User> currentUsers = [];

  Future<void> _onInitiated(_OnInitiated event, Emitter<AuthState> emit) async {
    await _userStreamSubscription?.cancel();
    _userStreamSubscription = _userProvider.userStream.listen(
      (customerProfile) => add(AuthEvent.onUserUpdated(customerProfile)),
      onError: (_) => add(const AuthEvent.onUserUpdated(null)),
    );
    await _userProvider.restoreUser();
  }

  Future<void> _onUserUpdated(_OnUserUpdated event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        userStateType: StateType.loaded,
        user: event.user,
      ),
    );
  }

  Future<void> _onSelectedImage(_OnSelectedImge event, Emitter<AuthState> emit) async {
    user = state.user!.copyWith(userPhotoPath: event.image);

    await _updateLocalUser(user, emit);

    await _getAllUsers(user, emit);

    await _clearUsersInStore(emit);

    currentUsers.add(user);

    await _updateUserList(emit);
  }

  Future<void> _updateUserList(Emitter<AuthState> emit) async {
    await _addLocalUsersUsecase
        .execute(param: currentUsers)
        .match(
          (_) => emit(state.copyWith(userStateType: StateType.error)),
          (_) => emit(state.copyWith(user: user)),
        )
        .run();
  }

  Future<void> _clearUsersInStore(Emitter<AuthState> emit) async {
    await _deleteUserUsecase
        .execute()
        .match(
          (_) => emit(state.copyWith(userStateType: StateType.error)),
          (_) {},
        )
        .run();
  }

  Future<void> _getAllUsers(User user, Emitter<AuthState> emit) async {
    await _getLocalUsersUsecase.execute().match(
      (_) => emit(state.copyWith(userStateType: StateType.error)),
      (users) {
        currentUsers = users.where((element) => element.email != user.email).toList();
      },
    ).run();
  }

  Future<void> _updateLocalUser(User user, Emitter<AuthState> emit) async {
    await _updateLocalUserUsecase
        .execute(param: user)
        .match(
          (_) => emit(state.copyWith(userStateType: StateType.error)),
          (_) => emit(state.copyWith(user: user)),
        )
        .run();
  }

  Future<void> _onAuthCheckRequested(_OnAuthCheckRequested event, Emitter<AuthState> emit) async =>
      _userProvider.restoreUser();

  Future<void> _onSignedOut(_OnSignedOut event, Emitter<AuthState> emit) async => _userProvider.deleteUser();

  @override
  Future<void> close() async {
    await _userStreamSubscription?.cancel();
    return super.close();
  }
}
