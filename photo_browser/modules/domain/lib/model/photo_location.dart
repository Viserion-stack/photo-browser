import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_location.freezed.dart';
part 'photo_location.g.dart';

@freezed
class PhotoLocation with _$PhotoLocation implements Storable {
  static const photoLocationStoreKey = 'photoLocation';

  factory PhotoLocation({
    required String city,
    required String country,
  }) = _PhotoLocation;

  factory PhotoLocation.fromJson(Map<String, dynamic> json) => _$PhotoLocationFromJson(json);
}
