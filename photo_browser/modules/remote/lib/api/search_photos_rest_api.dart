import 'package:dio/dio.dart';
import 'package:remote/models/search_photo_response/search_photos_response_remote_model.dart';
import 'package:retrofit/retrofit.dart';

part 'search_photos_rest_api.g.dart';

@RestApi()
abstract class SearchPhotosRestApi {
  factory SearchPhotosRestApi(Dio dio) = _SearchPhotosRestApi;

  @GET('/search/photos')
  Future<SearchPhotosResponseRemoteModel> searchPhotos({
    @Query('query') String query = '',
    @Query('page') int page = 0,
  });
}
