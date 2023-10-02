import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/widgets/photo_browser_text_input.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    required this.isLoginOpen,
    required this.isAnimationEnd,
    super.key,
  });

  final bool isLoginOpen;
  final bool isAnimationEnd;

  static const _durationAnimationSapcer = 1000;
  static const _heightAniamtionSapcer = 5.0;
  static const _heightAniamtionSapcerWhenIsNotLogin = 80.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: Insets.large,
        left: Insets.large,
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AnimatedContainer(
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: _durationAnimationSapcer),
              height: isLoginOpen ? _heightAniamtionSapcer : _heightAniamtionSapcerWhenIsNotLogin,
              width: double.infinity,
            ),
            _SignUpTitle(isLogin: isLoginOpen),
            if (isLoginOpen == false || !isAnimationEnd) ...[
              Gap.xxLarge,
              Gap.xxLarge,
              PhotoBrowserTextInput(text: context.strings.nameText),
              Gap.large,
              PhotoBrowserTextInput(text: context.strings.emailText),
              Gap.large,
              PhotoBrowserTextInput(text: context.strings.passwordText),
              Gap.large,
              PhotoBrowserTextInput(text: context.strings.confirmPasswordText),
              Gap.xxLarge,
              const _SignUpButton(),
            ],
          ],
        ),
      ),
    );
  }
}

class _SignUpTitle extends StatelessWidget {
  const _SignUpTitle({
    required this.isLogin,
    super.key,
  });

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(const LoginEvent.onSignUpOpened()),
      child: Column(
        children: [
          Gap.xLarge,
          Text(
            context.strings.newMemberText,
            style: context.textTheme.bodyMedium!.copyWith(color: context.palette.textOnPrimaryColor),
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 800),
            style: isLogin
                ? context.textTheme.displaySmall!.copyWith(color: context.palette.textOnPrimaryColor)
                : context.textTheme.displayLarge!.copyWith(color: context.palette.textOnPrimaryColor),
            child: Text(
              context.strings.signUpText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});

  static const _buttonRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.medium),
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.palette.primaryColor,
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        child: Center(
          child: Text(
            context.strings.signUpText,
            style: context.textTheme.bodyLarge!.copyWith(color: context.palette.accentVariantColor),
          ),
        ),
      ),
    );
  }
}
