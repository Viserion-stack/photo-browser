import 'package:flutter/material.dart';
import 'package:presentation/application/app_assets.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  static const _imageHeight = 40.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _imageHeight,
      width: double.infinity,
      child: context.svgImage(AppAssets.photoBrowserLogoNew),
    );
  }
}
