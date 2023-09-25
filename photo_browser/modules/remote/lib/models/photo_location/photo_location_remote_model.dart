import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_location_remote_model.freezed.dart';
part 'photo_location_remote_model.g.dart';

@freezed
class PhotoLocationRemoteModel with _$PhotoLocationRemoteModel {
  const factory PhotoLocationRemoteModel({
    required String city,
    required String country,
  }) = _PhotoLocationRemoteModel;

  factory PhotoLocationRemoteModel.fromJson(Map<String, dynamic> json) => _$PhotoLocationRemoteModelFromJson(json);
}
