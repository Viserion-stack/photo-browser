import 'package:domain/data_source_action/get_photo_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/photo_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class GetPhotoRemoteSourceActionImpl implements GetPhotoRemoteSourceAction {
  const GetPhotoRemoteSourceActionImpl({
    required PhotoRestApi photoRestApi,
    required ErrorConverter errorConverter,
    required Mapper<List<PhotoRemoteModel>, List<Photo>> photoRemoteToPhotoMapper,
  })  : _photoRestApi = photoRestApi,
        _errorConverter = errorConverter,
        _photoRemoteToPhotoMapper = photoRemoteToPhotoMapper;

  final PhotoRestApi _photoRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<List<PhotoRemoteModel>, List<Photo>> _photoRemoteToPhotoMapper;

  @override
  TaskEither<ErrorDetail, List<Photo>> execute() {
    return tryCatchE<ErrorDetail, List<Photo>>(
      () async {
        final response = await _photoRestApi.getPhotos();
        return right(_photoRemoteToPhotoMapper.map(response));
      },
      _errorConverter.handleRemoteError,
    );
  }
}
