import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_photos_request.freezed.dart';

@freezed
class SearchPhotosRequest with _$SearchPhotosRequest {
  factory SearchPhotosRequest({
    required String query,
    required int page,
  }) = _SearchPhotosRequest;
}
