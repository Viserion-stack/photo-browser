import 'dart:async';

import 'package:domain/model/user.dart';
import 'package:domain/usecase/get_local_user_usecase.dart';
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
  })  : _getLocalUserUsecase = getLocalUserUsecase,
        super(DashboardProfileState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
  }

  final GetLocalUserUsecase _getLocalUserUsecase;

  Future<void> _onInitiated(_OnInitiated event, Emitter<DashboardProfileState> emit) async {
    final newState = await _getLocalUserUsecase
        .execute()
        .match(
          (_) => state.copyWith(type: StateType.error),
          (user) => state.copyWith(
            type: StateType.loaded,
            user: user,
          ),
        )
        .run();

    emit(newState);
  }
}
