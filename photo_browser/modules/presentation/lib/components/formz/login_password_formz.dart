import 'package:formz/formz.dart';

enum LoginPasswordInputError { empty }

class LoginPasswordFormz extends FormzInput<String, LoginPasswordInputError> {
  const LoginPasswordFormz.pure() : super.pure('');

  const LoginPasswordFormz.dirty({
    String value = '',
  }) : super.dirty(value);

  @override
  LoginPasswordInputError? validator(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return LoginPasswordInputError.empty;
    }
    return null;
  }
}
