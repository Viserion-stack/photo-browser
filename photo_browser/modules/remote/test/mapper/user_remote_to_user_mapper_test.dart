import 'package:domain/model/user.dart';
import 'package:remote/mapper/user_remote_to_user_mapper.dart';
import 'package:remote/models/user/user_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'UserRemoteToUserMapper',
    () {
      late UserRemoteToUserMapper userRemoteToUserMapper;

      setUp(
        () => userRemoteToUserMapper = const UserRemoteToUserMapper(),
      );

      test(
        'should correctly map remote model to domain model',
        () {
          const userRemoteModel = UserRemoteModel(
            name: 'name',
            email: 'email',
            password: 'password',
          );

          final user = User.initial();

          final result = userRemoteToUserMapper.map(userRemoteModel);

          expect(result, user);
        },
      );
    },
  );
}
