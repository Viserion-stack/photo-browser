import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_remote_model.freezed.dart';
part 'photo_remote_model.g.dart';

@freezed
class PhotoRemoteModel with _$PhotoRemoteModel {
  const factory PhotoRemoteModel({
    required String id,
    required Map<String, dynamic> urls,
    String? description,
  }) = _PhotoRemoteModel;

  factory PhotoRemoteModel.fromJson(Map<String, dynamic> json) => _$PhotoRemoteModelFromJson(json);
}
