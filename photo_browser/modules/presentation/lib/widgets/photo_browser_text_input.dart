import 'package:flutter/material.dart';
import 'package:presentation/application/dimen.dart';
import 'package:presentation/application/theme.dart';

class PhotoBrowserTextInput extends StatelessWidget {
  const PhotoBrowserTextInput({
    required this.text,
    super.key,
  });

  final String text;

  //static const _borderSideWith = 1.0;
  static const _borderRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {},
      cursorColor: context.palette.primaryColor,
      style: context.textTheme.bodyLarge!.copyWith(color: context.palette.primaryColor),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: context.textTheme.bodyLarge!.copyWith(color: context.palette.primaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.palette.primaryColor,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.palette.primaryColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.palette.primaryColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Insets.small,
          horizontal: Insets.large,
        ),
      ),
    );
  }
}
