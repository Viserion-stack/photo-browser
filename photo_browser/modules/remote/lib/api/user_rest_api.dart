import 'package:dio/dio.dart' hide Headers;
import 'package:remote/models/user/user_remote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_rest_api.g.dart';

@RestApi()
abstract class UserRestApi {
  factory UserRestApi(Dio dio) = _UserRestApi;

  @GET('/users/1')
  Future<UserRemoteModel> getCurrentUser();

  @GET('/photos/?client_id=vS_xTaCqEL-WjfB0U3BGITdAbPtC9vuAkwLf_zSxh1k')
  Future<List<UserRemoteModel>> getPhotos();
}
