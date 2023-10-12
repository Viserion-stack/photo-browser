import 'package:formz/formz.dart';

enum NameInputError { empty, invalidLength }

class NameFormz extends FormzInput<String, NameInputError> {
  const NameFormz.pure() : super.pure('');

  const NameFormz.dirty({
    String value = '',
  }) : super.dirty(value);

  static const _minValue = 1;
  static const _maxValue = 255;

  @override
  NameInputError? validator(String value) {
    final trimmerdValue = value.trim();

    if (trimmerdValue.length < _minValue) {
      return NameInputError.empty;
    }

    if (trimmerdValue.length > _maxValue) {
      return NameInputError.invalidLength;
    }

    return null;
  }
}
