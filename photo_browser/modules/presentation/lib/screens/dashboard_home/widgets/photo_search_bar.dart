import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/dashboard_home/widgets/photo_browser_search_input.dart';

class PhotoSearchBar extends StatelessWidget {
  const PhotoSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: Insets.large),
      child: PhotoBrowserSearchInput(),
    );
  }
}
