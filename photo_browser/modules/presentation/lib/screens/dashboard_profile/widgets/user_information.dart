import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/screens/dashboard_profile/widgets/user_avatar.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  static const _informationHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: _informationHeight,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gap.xxxLarge,
            UserAvatar(),
            Gap.xLarge,
            _UserNameAndEmail(),
          ],
        ),
      ),
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  const _UserNameAndEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'John',
          style: context.textTheme.displayLarge!.copyWith(color: context.palette.accentVariantColor),
        ),
        Gap.xSmall,
        Text(
          'john.doe@gmail.com',
          style: context.textTheme.bodyMedium!.copyWith(color: context.palette.accentVariantColor),
        ),
      ],
    );
  }
}
