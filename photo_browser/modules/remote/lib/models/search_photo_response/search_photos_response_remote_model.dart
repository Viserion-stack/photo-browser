import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/photo/photo_remote_model.dart';

part 'search_photos_response_remote_model.freezed.dart';
part 'search_photos_response_remote_model.g.dart';

@freezed
class SearchPhotosResponseRemoteModel with _$SearchPhotosResponseRemoteModel {
  const factory SearchPhotosResponseRemoteModel({
    required int total,
    required List<PhotoRemoteModel> results,
  }) = _SearchPhotosResponseRemoteModel;

  factory SearchPhotosResponseRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$SearchPhotosResponseRemoteModelFromJson(json);
}
