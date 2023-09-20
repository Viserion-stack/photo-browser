import 'package:dio/dio.dart' hide Headers;
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'photo_rest_api.g.dart';

@RestApi()
abstract class PhotoRestApi {
  factory PhotoRestApi(Dio dio) = _PhotoRestApi;

  @GET('/photos')
  Future<List<PhotoRemoteModel>> getPhotos();
}
