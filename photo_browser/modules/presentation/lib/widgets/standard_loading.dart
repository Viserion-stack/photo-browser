import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';

class StandardLoading extends StatelessWidget {
  const StandardLoading({
    required this.size,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: context.palette.accentVariantColor,
        strokeWidth: 2,
      ),
    );
  }
}
