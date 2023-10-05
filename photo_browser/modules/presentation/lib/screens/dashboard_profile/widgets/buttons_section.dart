import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/components/auth/bloc/auth_bloc.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap.xxLarge,
        _ButtonSection(
          onTap: () {
            //TODO: Prepare screen with favorite photos
          },
          icon: Icons.favorite_border,
          title: context.strings.favoritePhotosText,
        ),
        Gap.large,
        _ButtonSection(
          onTap: () {
            //TODO: Prepare screen about app information
          },
          icon: Icons.info_outline_rounded,
          title: context.strings.informationText,
        ),
        Gap.large,
        _ButtonSection(
          onTap: () => context.read<AuthBloc>().add(const AuthEvent.onSignedOut()),
          icon: Icons.logout_outlined,
          title: context.strings.signOutText,
          isVisibleArrow: false,
        ),
      ],
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isVisibleArrow = true,
    super.key,
  });

  final IconData icon;
  final String title;
  final bool isVisibleArrow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            _ButtonIcon(icon: icon),
            HorizontalGap.large,
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.palette.accentVariantColor,
                ),
              ),
            ),
            if (isVisibleArrow) const _ArrowIcon(),
          ],
        ),
      ),
    );
  }
}

class _ButtonIcon extends StatelessWidget {
  const _ButtonIcon({
    required this.icon,
    super.key,
  });
  final IconData icon;

  static const _buttonIconSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _buttonIconSize,
      width: _buttonIconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.palette.accentVariantColor,
      ),
      child: Icon(
        icon,
        color: context.palette.cardColor,
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_outlined,
      color: context.palette.inactiveColor,
    );
  }
}
