import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/login_status.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/components/snack_bar/snack_bar.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/widgets/login_body.dart';
import 'package:presentation/screens/login/widgets/sign_up_body.dart';
import 'package:presentation/screens/login/widgets/sign_up_drawer.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/welcome';

  static const radius = 170.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.type != current.type && current.type == StateType.error,
          listener: (context, state) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.somethingWetnWrongMessage,
                background: context.palette.errorColor,
              ),
            );
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.loginStatus != current.loginStatus &&
              current.loginStatus == LoginStatus.incorrectEmailOrPassword,
          listener: (context, state) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.incorrectEmailOrPassword,
                background: context.palette.errorColor,
              ),
            );
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.loginStatus != current.loginStatus && current.loginStatus == LoginStatus.userNotExist,
          listener: (context, state) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.userNotExist,
                background: context.palette.errorColor,
              ),
            );
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.type != current.type && current.type == StateType.success,
          listener: (context, state) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.loggedMessage,
                background: context.palette.accentVariantColor,
              ),
            );
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.loginStatus != current.loginStatus && current.loginStatus == LoginStatus.registered,
          listener: (context, state) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.userRegistered,
                background: context.palette.accentVariantColor,
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final isLogin = state.isLoginOpened;
          final isAnimationEnd = state.isAnimationEnd;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: Stack(
              children: [
                const _LoginBackground(),
                LoginBody(
                  isLogin: isLogin,
                  isLoading: state.type == StateType.loading,
                ),
              ],
            ),
            bottomNavigationBar: SignUpDrawer(
              isLogin: isLogin,
              child: SignUpBody(
                isLoginOpen: isLogin,
                isAnimationEnd: isAnimationEnd,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginBackground extends StatelessWidget {
  const _LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.pexels.com/photos/1165005/pexels-photo-1165005.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
