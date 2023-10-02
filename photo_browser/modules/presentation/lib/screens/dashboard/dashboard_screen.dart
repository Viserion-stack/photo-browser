import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/dashboard_home/dashboard_home_screen.dart';
import 'package:presentation/screens/dashboard_profile/dashboard_profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const DashboardBottomNavigationBar(),
    );
  }
}

class DashboardBottomNavigationBar extends StatelessWidget {
  const DashboardBottomNavigationBar({super.key});

  static const _navigationBarRadius = Radius.circular(20);
  static const _iconTopPadding = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: _navigationBarRadius,
          topRight: _navigationBarRadius,
        ),
        border: Border.all(
          color: context.palette.accentVariantColor,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: _navigationBarRadius,
          topRight: _navigationBarRadius,
        ),
        child: BottomNavigationBar(
          fixedColor: Colors.transparent,
          useLegacyColorScheme: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: _iconTopPadding),
                child: Icon(Icons.home),
              ),
              label: context.strings.dashboardHome,
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(top: _iconTopPadding),
                child: Icon(Icons.person),
              ),
              label: context.strings.dashboardProfile,
            ),
          ],
          currentIndex: _calculateSelectedIndex(context),
          onTap: (index) => _onItemTapped(index, context),
        ),
      ),
    );
  }
}

int _calculateSelectedIndex(BuildContext context) {
  final location = GoRouterState.of(context).location;
  if (location.startsWith(DashboardHomeScreen.routeName)) {
    return 0;
  } else if (location.startsWith(DashboardProfileScreen.routeName)) {
    return 1;
  }
  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.go(DashboardHomeScreen.routeName);
    case 1:
      context.go(DashboardProfileScreen.routeName);
  }
}
