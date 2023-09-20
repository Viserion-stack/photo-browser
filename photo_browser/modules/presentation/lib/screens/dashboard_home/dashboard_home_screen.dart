import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/components/snack_bar/snack_bar.dart';
import 'package:presentation/screens/dashboard_home/bloc/dashboard_home_bloc.dart';
import 'package:presentation/screens/dashboard_home/widgets/photo_browser_appbar.dart';
import 'package:presentation/screens/dashboard_home/widgets/photo_grid_item.dart';
import 'package:presentation/widgets/photo_browser_loading_indicator.dart';

class DashboardHomeScreen extends StatelessWidget {
  static const routeName = '/dashboard-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PhotoBrowserAppBar(),
      body: BlocListener<DashboardHomeBloc, DashboardHomeState>(
        listener: (context, state) {
          if (state.type == StateType.error) {
            context.showSnackBarMessage(
              SnackBarMessage(
                message: context.strings.unexpectedError,
                background: context.palette.errorColor,
              ),
            );
          }
        },
        child: BlocBuilder<DashboardHomeBloc, DashboardHomeState>(
          builder: (context, state) {
            return state.type.map(
              loading: () => const PhotoBrowserLoadingIndicator(),
              loaded: () => const _DashboardHomeScreenBody(),
              error: () => const _DashboardHomeScreenError(),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardHomeScreenBody extends StatefulWidget {
  const _DashboardHomeScreenBody({super.key});

  @override
  State<_DashboardHomeScreenBody> createState() => _DashboardHomeScreenBodyState();
}

class _DashboardHomeScreenBodyState extends State<_DashboardHomeScreenBody> {
  static const _photoSpacing = 10.0;
  static const _photosPerRow = 2;
  static const _loadingIndicatorSize = 40.0;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(
        () {
          context.read<DashboardHomeBloc>().add(const DashboardHomeEvent.loadMorePhotos());
        },
      );
  }

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
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _controller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _photosPerRow,
                    mainAxisSpacing: _photoSpacing,
                    crossAxisSpacing: _photoSpacing,
                  ),
                  itemCount: state.photo.length,
                  itemBuilder: (context, index) => PhotoGridItem(imageUrl: state.photo[index].urls["thumb"].toString()),
                ),
              ),
              if (state.isLoadMoreRunning)
                const Center(
                  child: SizedBox(
                    height: _loadingIndicatorSize,
                    width: _loadingIndicatorSize,
                    child: PhotoBrowserLoadingIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _DashboardHomeScreenError extends StatelessWidget {
  const _DashboardHomeScreenError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.strings.noResults,
        style: context.textTheme.bodyMedium!.copyWith(
          color: context.palette.inactiveColor,
        ),
      ),
    );
  }
}
