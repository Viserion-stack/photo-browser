import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:presentation/application/app.dart';

class PhotoBrowserLoadingIndicator extends StatelessWidget {
  const PhotoBrowserLoadingIndicator({super.key});

  static const _indicatorStrokeWidth = 5.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotateMultiple,
        colors: [context.palette.accentVariantColor],
        strokeWidth: _indicatorStrokeWidth,
      ),
    );
  }
}
