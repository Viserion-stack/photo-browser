import 'package:domain/store/storable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User implements Storable {
  static const loggedInUserStoreKey = 'loggedInUserStore';

  factory User({
    required String name,
    required String email,
  }) = _User;

  factory User.initial() => User(
        name: 'name',
        email: 'email',
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
