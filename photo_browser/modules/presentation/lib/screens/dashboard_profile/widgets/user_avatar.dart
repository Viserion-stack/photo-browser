import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:presentation/application/app.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  static const _editButtonBottomPadding = 6.0;
  static const _editButtonRightPadding = 2.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Avatar(),
        Positioned(
          bottom: _editButtonBottomPadding,
          right: _editButtonRightPadding,
          child: _EditPhotoUserButton(
            onTap: () {
              //TODO: prepare functionality to add/edit user photo
            },
          ),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({super.key});

  static const _radiusFactor = 0.2;
  static const _duration = 2200;
  static const _avatarElevation = 8.0;
  static const _avatarRadius = 80.0;

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowRadiusFactor: _radiusFactor,
      glowColor: Colors.grey,
      duration: const Duration(milliseconds: _duration),
      child: const Material(
        elevation: _avatarElevation,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg',
          ),
          radius: _avatarRadius,
        ),
      ),
    );
  }
}

class _EditPhotoUserButton extends StatelessWidget {
  const _EditPhotoUserButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  static const _buttonSize = 35.0;
  static const _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _buttonSize,
        width: _buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.palette.accentVariantColor,
        ),
        child: Center(
          child: Icon(
            Icons.edit,
            color: context.palette.primaryColor,
            size: _iconSize,
          ),
        ),
      ),
    );
  }
}
