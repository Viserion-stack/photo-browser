import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/components/snack_bar/snack_bar.dart';
import 'package:presentation/screens/login/bloc/login_bloc.dart';
import 'package:presentation/screens/login/widgets/login_body.dart';
import 'package:presentation/screens/login/widgets/sign_up_body.dart';

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
                LoginBody(isLogin: isLogin),
              ],
            ),
            bottomNavigationBar: _SignUpDrawer(
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

class _SignUpDrawer extends StatelessWidget {
  const _SignUpDrawer({
    required this.child,
    required this.isLogin,
    super.key,
  });

  final Widget child;
  final bool isLogin;

  static const _signUpDrawerRadius = Radius.circular(80);
  static const _signUpDrawerHeight = 100.0;
  static const _signUpDrawerHeightWhenNotLogin = 600.0;
  static const _animationDuration = 800;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _OpenPainter(isLogin: isLogin),
      child: AnimatedContainer(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: _signUpDrawerRadius,
            topRight: _signUpDrawerRadius,
          ),
        ),
        padding: EdgeInsets.zero,
        curve: Curves.easeInCubic,
        height: isLogin ? _signUpDrawerHeight : _signUpDrawerHeightWhenNotLogin,
        width: double.infinity,
        duration: const Duration(milliseconds: _animationDuration),
        child: child,
      ),
    );
  }
}

class _OpenPainter extends CustomPainter {
  _OpenPainter({required this.isLogin});

  final bool isLogin;

  static const _arcPoint = 0.15;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Path path = Path();
    path
      ..moveTo(0, size.height * _arcPoint)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height * _arcPoint)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
