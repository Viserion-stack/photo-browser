import 'package:domain/model/user.dart';
import 'package:domain/store/multi_value_store.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:foundation/foundation.dart';
import 'package:fpdart/fpdart.dart';

enum RegisterLocalUserFailure { fatal }

class RegisterLocalUserUsecase implements ParamUseCase<RegisterLocalUserFailure, bool, User> {
  const RegisterLocalUserUsecase({
    required MultiValueStore<User> userMultiValueStore,
  }) : _userMultiValueStore = userMultiValueStore;

  final MultiValueStore<User> _userMultiValueStore;

  @override
  TaskEither<RegisterLocalUserFailure, bool> execute({required User param}) {
    return tryCatchE(
      () async {
        final result = await _userMultiValueStore.add(value: param);

        return right(result);
      },
      (error, stackTrace) => RegisterLocalUserFailure.fatal,
    );
  }
}
