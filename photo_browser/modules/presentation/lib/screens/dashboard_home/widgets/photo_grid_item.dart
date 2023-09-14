import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  static const _itemHeight = 90.0;
  static const _imageWidth = 60.0;
  static const _itemRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _itemHeight,
      width: _imageWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: context.palette.primaryColor),
        borderRadius: BorderRadius.circular(_itemRadius),
      ),
    );
  }
}
