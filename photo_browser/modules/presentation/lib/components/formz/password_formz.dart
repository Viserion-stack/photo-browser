import 'package:formz/formz.dart';

enum PasswordInputError { invalidLength, invalidFormat }

class PasswordFormz extends FormzInput<String, PasswordInputError> {
  const PasswordFormz.pure() : super.pure('');

  const PasswordFormz.dirty({
    String value = '',
  }) : super.dirty(value);

  static const minLength = 8;

  static const _lowerCaseRegex = '[a-zżółćęśąźń]';
  static const _upperCaseRegex = '[A-ZŻÓŁĆĘŚĄŹŃ]';
  static const _numberRegex = '[0-9]';
  static const _specialCharRegex = '[^a-zA-Z0-9żółćęśąźńŻÓŁĆĘŚĄŹŃ]';

  @override
  PasswordInputError? validator(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.length < minLength) {
      return PasswordInputError.invalidLength;
    }
    if (_getScore(trimmedValue) >= 3) {
      return null;
    }
    return PasswordInputError.invalidFormat;
  }

  int _getScore(String password) {
    return (RegExp(_lowerCaseRegex).hasMatch(password) ? 1 : 0) +
        (RegExp(_upperCaseRegex).hasMatch(password) ? 1 : 0) +
        (RegExp(_numberRegex).hasMatch(password) ? 1 : 0) +
        (RegExp(_specialCharRegex).hasMatch(password) ? 1 : 0);
  }
}
