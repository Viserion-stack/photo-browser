import 'dart:async';

import 'package:domain/usecase/get_local_user_usecase.dart';
import 'package:domain/usecase/get_local_users_usecase.dart';
import 'package:domain/usecase/update_local_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/dashboard_profile/dashboard_profile_argument.dart';

part 'dashboard_profile_bloc.freezed.dart';

part 'dashboard_profile_event.dart';

part 'dashboard_profile_state.dart';

class DashboardProfileBloc extends Bloc<DashboardProfileEvent, DashboardProfileState> {
  DashboardProfileBloc({
    required DashboardProfileArgument argument,
    required GetLocalUserUsecase getLocalUserUsecase,
    required UpdateLocalUserUsecase updateLocalUserUsecase,
    required GetLocalUsersUsecase getLocalUsersUsecase,
  })  : _getLocalUserUsecase = getLocalUserUsecase,
        _getLocalUsersUsecase = getLocalUsersUsecase,
        _updateLocalUserUsecase = updateLocalUserUsecase,
        super(DashboardProfileState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_OnSelectedProfileImage>(_onSelectedImage);
  }

  final GetLocalUserUsecase _getLocalUserUsecase;
  final GetLocalUsersUsecase _getLocalUsersUsecase;
  final UpdateLocalUserUsecase _updateLocalUserUsecase;

  Future<void> _onInitiated(_OnInitiated event, Emitter<DashboardProfileState> emit) async {
    emit(state.copyWith(type: StateType.loaded));
  }

  Future<void> _onSelectedImage(_OnSelectedProfileImage event, Emitter<DashboardProfileState> emit) async {
    emit(state.copyWith(profileImagePath: event.imagePath));
  }
}
