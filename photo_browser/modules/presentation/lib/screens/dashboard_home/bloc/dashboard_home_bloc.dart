import 'dart:async';

import 'package:domain/model/photo.dart';
import 'package:domain/model/search_photos_request.dart';
import 'package:domain/usecase/get_photo_usecase.dart';
import 'package:domain/usecase/search_photos_usecase.dart';
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
    required GetPhotoUsecase getPhotoUsecase,
    required SearchPhotosUsecase searchPhotosUsecase,
  })  : _getPhotoUsecase = getPhotoUsecase,
        _searchPhotosUsecase = searchPhotosUsecase,
        super(DashboardHomeState.initial(argument: argument)) {
    on<_OnInitiated>(_onInitiated);
    on<_PhotosFetched>(_onPhotoFetched);
    on<_PhotosSearched>(_onPhotosSearched);
    on<_LoadedMorePhotos>(_onLoadedMorePhotos);
  }

  final GetPhotoUsecase _getPhotoUsecase;
  final SearchPhotosUsecase _searchPhotosUsecase;

  String currentQuery = '';
  int currentPage = 1;
  List<Photo> photos = [];
  bool hasNextPage = false;

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

  Future<void> _onPhotosSearched(_PhotosSearched event, Emitter<DashboardHomeState> emit) async {
    emit(state.copyWith(type: StateType.loading));

    if (event.query != currentQuery) {
      currentQuery = event.query;
      currentPage = 1;
      photos = [];
    }

    final result = await _searchPhotosUsecase
        .execute(
            param: SearchPhotosRequest(
      query: event.query,
      page: currentPage,
    ))
        .match(
      (l) => state.copyWith(
        photo: state.photo,
        type: StateType.error,
      ),
      (r) {
        photos.addAll(r);
        hasNextPage = true;
        return state.copyWith(
          photo: photos,
          type: StateType.loaded,
        );
      },
    ).run();

    emit(result);
  }

  Future<void> _onLoadedMorePhotos(_LoadedMorePhotos event, Emitter<DashboardHomeState> emit) async {
    if (state.isLoadMoreRunning == false && hasNextPage && currentPage < 5) {
      emit(state.copyWith(isLoadMoreRunning: true));

      currentPage += 1;

      final result = await _searchPhotosUsecase
          .execute(
        param: SearchPhotosRequest(
          query: currentQuery,
          page: currentPage,
        ),
      )
          .match(
        (l) => state.copyWith(
          photo: state.photo,
          type: StateType.error,
        ),
        (r) {
          if (r.isNotEmpty) {
            photos.addAll(r);
            return state.copyWith(
              photo: photos,
              type: StateType.loaded,
              isLoadMoreRunning: false,
            );
          } else {
            hasNextPage = false;
            return state.copyWith(
              photo: photos,
              type: StateType.loaded,
              isLoadMoreRunning: false,
            );
          }
        },
      ).run();

      emit(result);
    }
  }
}
