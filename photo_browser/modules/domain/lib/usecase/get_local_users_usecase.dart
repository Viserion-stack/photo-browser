import 'package:domain/model/user.dart';
import 'package:domain/store/multi_value_store.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum GetLocalUsersFailure { fatal }

class GetLocalUsersUsecase implements UseCase<GetLocalUsersFailure, List<User>> {
  const GetLocalUsersUsecase({
    required MultiValueStore<User> usersMultiValueStore,
  }) : _usersMultiValueStore = usersMultiValueStore;

  final MultiValueStore<User> _usersMultiValueStore;

  @override
  TaskEither<GetLocalUsersFailure, List<User>> execute() {
    return tryCatchE(
      () async {
        final result = await _usersMultiValueStore.getAll();

        return right(result);
      },
      (error, stackTrace) => GetLocalUsersFailure.fatal,
    );
  }
}
