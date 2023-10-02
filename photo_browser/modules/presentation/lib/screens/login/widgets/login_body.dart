import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app_localizations.dart';
import 'package:presentation/application/dimen.dart';
import 'package:presentation/application/theme.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/widgets/photo_browser_text_input.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    required this.isLogin,
    super.key,
  });

  final bool isLogin;

  static const _loginBodyHeight = 350.0;
  static const _loginBodyHeightWhenNotLogin = 80.0;
  static const _animationDuration = 1800;
  static const _animationDurationWhenNotLogin = 1100;
  static const _loginBodyTopPadding = 200.0;
  static const _loginBodyTopPaddingWhenNotLogin = 60.0;
  static const _loginBodyRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      right: Insets.large,
      left: Insets.large,
      height: isLogin ? _loginBodyHeight : _loginBodyHeightWhenNotLogin,
      duration: Duration(milliseconds: isLogin ? _animationDuration : _animationDurationWhenNotLogin),
      top: !isLogin ? _loginBodyTopPaddingWhenNotLogin : _loginBodyTopPadding,
      child: Container(
        decoration: BoxDecoration(
          color: isLogin ? Colors.black54 : Colors.black,
          borderRadius: BorderRadius.circular(_loginBodyRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.xLarge,
            vertical: Insets.large,
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLogin) Gap.large else Gap.small,
                const _LoginTitle(),
                const _LoginForm(),
                const _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginTitle extends StatelessWidget {
  const _LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(const LoginEvent.onLoginOpened()),
      child: Text(
        context.strings.loginTitle,
        style: context.textTheme.displayMedium!.copyWith(color: context.palette.primaryColor),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  static const _loginButtonRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(const LoginEvent.onLoggedIn()),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.medium),
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.palette.primaryColor,
          borderRadius: BorderRadius.circular(_loginButtonRadius),
        ),
        child: Center(
          child: Text(
            context.strings.loginText,
            style: context.textTheme.bodyLarge!.copyWith(color: context.palette.accentVariantColor),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap.xxxLarge,
        PhotoBrowserTextInput(text: context.strings.emailText),
        Gap.large,
        PhotoBrowserTextInput(text: context.strings.passwordText),
        Gap.xxLarge,
      ],
    );
  }
}
