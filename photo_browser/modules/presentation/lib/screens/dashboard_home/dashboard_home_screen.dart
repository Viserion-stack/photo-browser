import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/dashboard_home/bloc/dashboard_home_bloc.dart';
import 'package:presentation/screens/dashboard_home/widgets/photo_grid_item.dart';
import 'package:presentation/widgets/photo_browser_appbar.dart';
import 'package:presentation/widgets/photo_browser_loading_indicator.dart';

class DashboardHomeScreen extends StatelessWidget {
  static const routeName = '/dashboard-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PhotoBrowserAppBar(),
      body: BlocBuilder<DashboardHomeBloc, DashboardHomeState>(
        builder: (context, state) {
          return state.type.map(
            loading: () => const PhotoBrowserLoadingIndicator(),
            loaded: () => const _DashboardHomeScreenBody(),
          );
        },
      ),
    );
  }
}

class _DashboardHomeScreenBody extends StatelessWidget {
  const _DashboardHomeScreenBody({super.key});

  static const _photoSpacing = 10.0;
  static const _photosPerRow = 2;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardHomeBloc, DashboardHomeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: Insets.large,
            right: Insets.large,
            top: Insets.xLarge,
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _photosPerRow,
              mainAxisSpacing: _photoSpacing,
              crossAxisSpacing: _photoSpacing,
            ),
            itemCount: state.photo.length,
            itemBuilder: (context, index) => PhotoGridItem(imageUrl: state.photo[index].urls["regular"].toString()),
          ),
        );
      },
    );
  }
}
