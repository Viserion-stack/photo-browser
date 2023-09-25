import 'package:domain/data_source_action/get_photo_details_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo_details.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/photo_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo_details/photo_details_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class GetPhotoDetailsRemoteSourceActionImpl implements GetPhotoDetailsRemoteSourceAction {
  const GetPhotoDetailsRemoteSourceActionImpl({
    required ErrorConverter errorConverter,
    required Mapper<PhotoDetailsRemoteModel, PhotoDetails> photoDetailsRemoteToPhotoDetails,
    required PhotoRestApi photoRestApi,
  })  : _errorConverter = errorConverter,
        _photoDetailsRemoteToPhotoDetails = photoDetailsRemoteToPhotoDetails,
        _photoRestApi = photoRestApi;

  final ErrorConverter _errorConverter;
  final Mapper<PhotoDetailsRemoteModel, PhotoDetails> _photoDetailsRemoteToPhotoDetails;
  final PhotoRestApi _photoRestApi;

  @override
  TaskEither<ErrorDetail, PhotoDetails> execute({required String id}) {
    return tryCatchE(
      () async {
        final response = await _photoRestApi.getPhotoDetails(id: id);

        return right(_photoDetailsRemoteToPhotoDetails.map(response));
      },
      _errorConverter.handleRemoteError,
    );
  }
}
