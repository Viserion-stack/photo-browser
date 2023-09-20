import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/dashboard_home/widgets/photo_search_bar.dart';
import 'package:presentation/widgets/logo_widget.dart';

class PhotoBrowserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PhotoBrowserAppBar({super.key});

  static const _height = 40.0;
  static const _topPadding = 55.0;
  static const _appBarHeight = 96.0;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: _topPadding),
      child: Column(
        children: [
          SizedBox(
            height: _height,
            width: double.infinity,
            child: LogoWidget(),
          ),
          Gap.medium,
          Expanded(child: PhotoSearchBar()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);
}
