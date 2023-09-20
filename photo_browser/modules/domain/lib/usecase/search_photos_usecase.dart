import 'package:domain/data_source_action/search_photos_remote_source_action.dart';
import 'package:domain/model/photo.dart';
import 'package:domain/model/search_photos_request.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum SearchPhotosFailure { fatal }

class SearchPhotosUsecase implements ParamUseCase<SearchPhotosFailure, List<Photo>, SearchPhotosRequest> {
  const SearchPhotosUsecase({
    required SearchPhotosRemoteSourceAction searchPhotosRemoteSourceAction,
  }) : _searchPhotosRemoteSourceAction = searchPhotosRemoteSourceAction;

  final SearchPhotosRemoteSourceAction _searchPhotosRemoteSourceAction;

  @override
  TaskEither<SearchPhotosFailure, List<Photo>> execute({required SearchPhotosRequest param}) {
    return _searchPhotosRemoteSourceAction.execute(param.query, param.page).bimap(
          (errorDetail) => errorDetail.map(
            backend: (backendError) {
              switch (backendError.errorCode) {
                default:
                  return SearchPhotosFailure.fatal;
              }
            },
            fatal: (fatalError) => SearchPhotosFailure.fatal,
          ),
          (r) => r,
        );
  }
}
