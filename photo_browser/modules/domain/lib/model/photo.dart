import 'package:domain/model/photographer.dart';
import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
class Photo with _$Photo implements Storable {
  static const photoStoreKey = 'photoStore';

  factory Photo({
    required String id,
    required Map<String, dynamic> urls,
    String? description,
    Photographer? user,
    int? likes,
  }) = _Photo;

  factory Photo.initial() => Photo(
        id: 'id',
        urls: {},
        description: 'description',
        likes: 0,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
