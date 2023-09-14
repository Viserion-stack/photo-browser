import 'dart:async';

import 'package:domain/model/photo.dart';

import 'package:domain/usecase/get_photo_usecase.dart';
import 'package:domain/usecase/get_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/dashboard_home/dashboard_home_argument.dart';

part 'dashboard_home_bloc.freezed.dart';

part 'dashboard_home_event.dart';

part 'dashboard_home_state.dart';

class DashboardHomeBloc extends Bloc<DashboardHomeEvent, DashboardHomeState> {
  DashboardHomeBloc({
    required DashboardHomeArgument argument,
    required GetUserUsecase getUserUsecase,
    required GetPhotoUsecase getPhotoUsecase,
  })  : _getUserUsecase = getUserUsecase,
        _getPhotoUsecase = getPhotoUsecase,
        super(DashboardHomeState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_PhotosFetched>(_onPhotoFetched);
  }

  final GetUserUsecase _getUserUsecase;
  final GetPhotoUsecase _getPhotoUsecase;

  Future<void> _onInitiated(_OnInitiated event, Emitter<DashboardHomeState> emit) async {}

  Future<void> _onPhotoFetched(_PhotosFetched event, Emitter<DashboardHomeState> emit) async {
    emit(state.copyWith(type: StateType.loading));
    final result = await _getPhotoUsecase
        .execute()
        .match(
          (l) => state.copyWith(
            photo: state.photo,
            type: StateType.error,
          ),
          (r) => state.copyWith(
            photo: r,
            type: StateType.loaded,
          ),
        )
        .run();

    emit(result);
  }
}
