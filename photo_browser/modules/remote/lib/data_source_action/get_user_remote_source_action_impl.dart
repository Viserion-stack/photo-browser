import 'package:domain/data_source_action/get_user_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/user.dart';
import 'package:foundation/fpdarts.dart';
import 'package:fpdart/fpdart.dart';
import 'package:remote/api/user_rest_api.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/user/user_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';

class GetUserRemoteSourceActionImpl implements GetUserRemoteSourceAction {
  const GetUserRemoteSourceActionImpl({
    required UserRestApi userRestApi,
    required ErrorConverter errorConverter,
    required Mapper<List<UserRemoteModel>, List<User>> userRemoteToUserMapper,
  })  : _userRestApi = userRestApi,
        _errorConverter = errorConverter,
        _userRemoteToUserMapper = userRemoteToUserMapper;

  final UserRestApi _userRestApi;
  final ErrorConverter _errorConverter;
  final Mapper<List<UserRemoteModel>, List<User>> _userRemoteToUserMapper;

  @override
  TaskEither<ErrorDetail, List<User>> execute() {
    return tryCatchE<ErrorDetail, List<User>>(
      () async {
        final response = await _userRestApi.getPhotos();
        return right(_userRemoteToUserMapper.map(response ) );
      },
      _errorConverter.handleRemoteError,
    );
  }
}
