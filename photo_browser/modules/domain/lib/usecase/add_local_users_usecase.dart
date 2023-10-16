import 'package:domain/model/user.dart';
import 'package:domain/store/multi_value_store.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum AddLocalUsersFailure { fatal }

class AddLocalUsersUsecase implements ParamUseCase<AddLocalUsersFailure, bool, List<User>> {
  const AddLocalUsersUsecase({
    required MultiValueStore<User> userMultiValueStore,
  }) : _userMultiValueStore = userMultiValueStore;

  final MultiValueStore<User> _userMultiValueStore;
  @override
  TaskEither<AddLocalUsersFailure, bool> execute({required List<User> param}) {
    return tryCatchE(
      () async {
        final result = await _userMultiValueStore.addAll(values: param);

        return right(result);
      },
      (error, stackTrace) => AddLocalUsersFailure.fatal,
    );
  }
}
