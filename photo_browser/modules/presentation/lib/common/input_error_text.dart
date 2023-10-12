import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/components/formz/email_formz.dart';
import 'package:presentation/components/formz/login_password_formz.dart';
import 'package:presentation/components/formz/name_formz.dart';
import 'package:presentation/components/formz/password_formz.dart';

String? nameErrorText(BuildContext context, NameFormz nameFormz) {
  if (nameFormz.isNotValid) {
    switch (nameFormz.error) {
      case NameInputError.empty:
        return context.strings.inputEmpty;
      case NameInputError.invalidLength:
        return context.strings.nameInvalidLength;
      default:
        return null;
    }
  }
  return null;
}

String? emailErrorText(BuildContext context, EmailFormz emailFormz) {
  if (emailFormz.isNotValid) {
    switch (emailFormz.error) {
      case EmailInputError.empty:
        return context.strings.inputEmpty;
      case EmailInputError.wrongValue:
        return context.strings.emailWrongValue;
      default:
        return null;
    }
  }
  return null;
}

String? passwordErrorText(BuildContext context, PasswordFormz passwordFormz) {
  if (passwordFormz.isNotValid) {
    switch (passwordFormz.error) {
      case PasswordInputError.invalidFormat:
        return context.strings.passwordInvalidFormat;
      case PasswordInputError.invalidLength:
        return context.strings.passwordInvalidLength;
      default:
        return null;
    }
  }
  return null;
}

String? loginPasswordErrorText(BuildContext context, LoginPasswordFormz loginPasswordFormz) {
  if (loginPasswordFormz.isNotValid) {
    switch (loginPasswordFormz.error) {
      case LoginPasswordInputError.empty:
        return context.strings.completePassword;
      default:
        return null;
    }
  }
  return null;
}
