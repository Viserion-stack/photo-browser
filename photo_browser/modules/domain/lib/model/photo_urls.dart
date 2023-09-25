import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_urls.freezed.dart';
part 'photo_urls.g.dart';

@freezed
class PhotoUrls with _$PhotoUrls implements Storable {
  static const photoUrlsStorableKey = 'photoUrls';

  factory PhotoUrls({
    required String raw,
    required String full,
    required String small,
    required String thumb,
  }) = _PhotoUrls;

  factory PhotoUrls.fromJson(Map<String, dynamic> json) => _$PhotoUrlsFromJson(json);
}
