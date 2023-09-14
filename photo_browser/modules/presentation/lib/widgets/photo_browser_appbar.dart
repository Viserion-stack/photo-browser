import 'package:flutter/material.dart';
import 'package:presentation/widgets/logo_widget.dart';

class PhotoBrowserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PhotoBrowserAppBar({super.key});

  static const height = 40.0;
  static const topPadding = 55.0;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: LogoWidget(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(height);
}
