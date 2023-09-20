import 'package:freezed_annotation/freezed_annotation.dart';

part 'photographer_remote_model.freezed.dart';
part 'photographer_remote_model.g.dart';

@freezed
class PhotographerRemoteModel with _$PhotographerRemoteModel {
  const factory PhotographerRemoteModel({
    required String id,
    required String username,
  }) = _PhotographerRemoteModel;

  factory PhotographerRemoteModel.fromJson(Map<String, dynamic> json) => _$PhotographerRemoteModelFromJson(json);
}
