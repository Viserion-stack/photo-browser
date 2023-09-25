import 'package:domain/model/photo_location.dart';
import 'package:domain/model/photo_urls.dart';
import 'package:domain/model/photographer.dart';
import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_details.freezed.dart';
part 'photo_details.g.dart';

@freezed
class PhotoDetails with _$PhotoDetails implements Storable {
  factory PhotoDetails({
    required String id,
    required PhotoUrls urls,
    required Photographer user,
    required PhotoLocation location,
    required int likes,
    String? description,
  }) = _PhotoDetails;

  factory PhotoDetails.fromJson(Map<String, dynamic> json) => _$PhotoDetailsFromJson(json);
}
