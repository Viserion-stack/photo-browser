import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User implements Storable {
  static const loggedInUserStoreKey = 'loggedInUserStore';

   factory User({
    required String id,
    required Map<String, dynamic> urls,
    String? description,
  }) = _User;

   factory User.initial() =>   User(id: 'dupa', description: '', urls: {},);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
