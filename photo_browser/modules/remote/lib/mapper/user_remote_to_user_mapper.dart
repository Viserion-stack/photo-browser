import 'package:domain/model/user.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/user/user_remote_model.dart';

class UserRemoteToUserMapper implements Mapper<List<UserRemoteModel>, List<User>> {
  const UserRemoteToUserMapper();

  @override
  List<User> map(List<UserRemoteModel> element) {
    final userList = element
        .map(
          (e) => User(
            id: e.id,
            urls: e.urls,
            description: e.description,
          ),
        )
        .toList();
    return userList;
  }
}
