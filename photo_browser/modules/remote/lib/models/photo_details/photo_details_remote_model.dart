import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:remote/models/photo_location/photo_location_remote_model.dart';
import 'package:remote/models/photo_urls/photo_urls_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';

part 'photo_details_remote_model.freezed.dart';
part 'photo_details_remote_model.g.dart';

@freezed
class PhotoDetailsRemoteModel with _$PhotoDetailsRemoteModel {
  const factory PhotoDetailsRemoteModel({
    required String id,
    required PhotoUrlsRemoteModel urls,
    required PhotoLocationRemoteModel location,
    required PhotographerRemoteModel user,
    required int likes,
    String? description,
  }) = _PhotoDetailsRemoteModel;

  factory PhotoDetailsRemoteModel.fromJson(Map<String, dynamic> json) => _$PhotoDetailsRemoteModelFromJson(json);
}
