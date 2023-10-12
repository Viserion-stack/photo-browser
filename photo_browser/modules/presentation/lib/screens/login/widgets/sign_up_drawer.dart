import 'package:flutter/material.dart';

class SignUpDrawer extends StatelessWidget {
  const SignUpDrawer({
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
