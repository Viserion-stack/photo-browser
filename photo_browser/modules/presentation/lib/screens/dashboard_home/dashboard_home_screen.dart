import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/screens/dashboard_home/bloc/dashboard_home_bloc.dart';

class DashboardHomeScreen extends StatelessWidget {
  static const routeName = '/dashboard-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DashboardHomeBloc, DashboardHomeState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Home'),
                ElevatedButton(
                  onPressed: () => context.read<DashboardHomeBloc>().add(const DashboardHomeEvent.photosFetched()),
                  child: const Text('Get photo'),
                ),
                Text(state.user[0].description ?? 'null'),
              ],
            ),
          );
        },
      ),
    );
  }
}
