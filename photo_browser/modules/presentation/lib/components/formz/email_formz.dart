import 'package:formz/formz.dart';

enum EmailInputError {
  empty,
  wrongValue,
}

class EmailFormz extends FormzInput<String, EmailInputError> {
  const EmailFormz.pure() : super.pure('');

  static const _emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  const EmailFormz.dirty({
    String value = '',
  }) : super.dirty(value);

  @override
  EmailInputError? validator(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return EmailInputError.empty;
    }

    final emailRegex = RegExp(_emailRegex);
    final isEmail = emailRegex.hasMatch(trimmedValue);

    if (!isEmail) {
      return EmailInputError.wrongValue;
    }

    return null;
  }
}
