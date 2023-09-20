import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photographer.freezed.dart';
part 'photographer.g.dart';

@freezed
class Photographer with _$Photographer implements Storable {
  static const photographerStoreKey = 'photographerStore';

  factory Photographer({
    required String id,
    required String username,
  }) = _Photographer;

  factory Photographer.fromJson(Map<String, dynamic> json) => _$PhotographerFromJson(json);
}
