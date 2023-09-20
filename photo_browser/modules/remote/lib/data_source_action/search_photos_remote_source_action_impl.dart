import 'package:domain/data_source_action/search_photos_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/search_photos_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class SearchPhotosRemoteSourceActionImpl implements SearchPhotosRemoteSourceAction {
  const SearchPhotosRemoteSourceActionImpl(
      {required SearchPhotosRestApi searchPhotosRestApi,
      required ErrorConverter errorConverter,
      required Mapper<PhotoRemoteModel, Photo> photoRemoteToPhotoMapper})
      : _searchPhotosRestApi = searchPhotosRestApi,
        _errorConverter = errorConverter,
        _photoRemoteToPhotoMapper = photoRemoteToPhotoMapper;

  final SearchPhotosRestApi _searchPhotosRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<PhotoRemoteModel, Photo> _photoRemoteToPhotoMapper;

  @override
  TaskEither<ErrorDetail, List<Photo>> execute(String query, int page) {
    return tryCatchE(
      () async {
        final response = await _searchPhotosRestApi.searchPhotos(page: page, query: query);
        final photos = response.results
            .map(
              _photoRemoteToPhotoMapper.map,
            )
            .toList();
        return right(photos);
      },
      _errorConverter.handleRemoteError,
    );
  }
}
