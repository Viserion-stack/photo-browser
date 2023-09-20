import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/dashboard_home/bloc/dashboard_home_bloc.dart';

class PhotoBrowserSearchInput extends StatefulWidget {
  const PhotoBrowserSearchInput({
    super.key,
  });

  @override
  State<PhotoBrowserSearchInput> createState() => _PhotoBrowserSearchInputState();
}

class _PhotoBrowserSearchInputState extends State<PhotoBrowserSearchInput> {
  static const _borderSideWith = 3.0;
  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        if (query.length > 3) {
          context.read<DashboardHomeBloc>().add(DashboardHomeEvent.photosSearched(query: query));
        }
      },
      decoration: InputDecoration(
        hintText: context.strings.searchInputHintText,
        hintStyle: context.textTheme.bodyLarge,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.palette.primaryColor,
            width: _borderSideWith,
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
