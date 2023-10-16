import 'package:domain/model/user.dart';
import 'package:domain/store/multi_value_store.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum DeleteUserFailure { fatal }

class DeleteUserUsecase implements UseCase<DeleteUserFailure, void> {
  const DeleteUserUsecase({
    required MultiValueStore<User> userMultiValueStore,
  }) : _userMultiValueStore = userMultiValueStore;

  final MultiValueStore<User> _userMultiValueStore;

  @override
  TaskEither<DeleteUserFailure, void> execute() {
    return tryCatchE(
      () async {
        final result = await _userMultiValueStore.removeAll();

        return right(result);
      },
      (error, stackTrace) => DeleteUserFailure.fatal,
    );
  }
}
