import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_urls_remote_model.freezed.dart';
part 'photo_urls_remote_model.g.dart';

@freezed
class PhotoUrlsRemoteModel with _$PhotoUrlsRemoteModel {
  const factory PhotoUrlsRemoteModel({
    required String raw,
    required String full,
    required String small,
    required String thumb,
  }) = _PhotoUrlsRemoteModel;

  factory PhotoUrlsRemoteModel.fromJson(Map<String, dynamic> json) => _$PhotoUrlsRemoteModelFromJson(json);
}
