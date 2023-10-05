import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/state_type.dart';
import 'package:presentation/screens/dashboard_profile/bloc/dashboard_profile_bloc.dart';
import 'package:presentation/screens/dashboard_profile/widgets/buttons_section.dart';
import 'package:presentation/screens/dashboard_profile/widgets/user_information.dart';

class DashboardProfileScreen extends StatelessWidget {
  static const routeName = '/dashboard-profile';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardProfileBloc, DashboardProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: state.type.map(
            loading: SizedBox.shrink,
            loaded: () => const _ProfileScreenBody(),
          ),
        );
      },
    );
  }
}

class _ProfileScreenBody extends StatelessWidget {
  const _ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.large),
      child: Column(
        children: [
          Gap.xLarge,
          const UserInformation(),
          Gap.xLarge,
          _EditProfileButton(
            onTap: () {
              //TODO: Prepare functionality to edit user information
            },
          ),
          Gap.xLarge,
          const ButtonsSection(),
        ],
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  static const _buttonWidth = 200.0;
  static const _buttonRadius = 30.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _buttonWidth,
        padding: const EdgeInsets.symmetric(vertical: Insets.medium),
        decoration: BoxDecoration(
          color: context.palette.accentVariantColor,
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        child: Center(
          child: Text(
            context.strings.editProfileText,
            style: context.textTheme.bodyMedium!.copyWith(
              color: context.palette.cardColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
