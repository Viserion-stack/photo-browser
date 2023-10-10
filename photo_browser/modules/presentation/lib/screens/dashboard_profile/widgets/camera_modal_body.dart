import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/common/photo_browser_image_picker.dart';
import 'package:presentation/components/auth/bloc/auth_bloc.dart';

class CameraModalBody extends StatelessWidget {
  const CameraModalBody({super.key});

  static const _modalHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _modalHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.large, vertical: Insets.xLarge),
        child: Column(
          children: [
            Text(
              context.strings.camerModalTitle,
              style: context.textTheme.labelLarge!.copyWith(color: context.palette.accentVariantColor),
            ),
            Gap.xxLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CameraModalButton(
                  title: context.strings.galleryText,
                  onTap: () async {
                    final photo = await usePhotoBrowserImagePicker();
                    // ignore: use_build_context_synchronously
                    context
                      ..read<AuthBloc>().add(AuthEvent.onSelectedImage(image: photo!.path))
                      ..pop();
                  },
                ),
                HorizontalGap.large,
                _CameraModalButton(
                  title: context.strings.cameraText,
                  onTap: () {},
                  isCameraButton: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CameraModalButton extends StatelessWidget {
  const _CameraModalButton({
    required this.title,
    required this.onTap,
    this.isCameraButton = false,
    super.key,
  });

  final String title;
  final VoidCallback onTap;
  final bool isCameraButton;

  static const _cameraModalButtonRadius = 30.0;
  static const _cameraModalButtonBorderWith = 2.0;
  static const _cameraModalButtonWidth = 150.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Insets.small),
        decoration: BoxDecoration(
          color: !isCameraButton ? context.palette.cardColor : context.palette.accentVariantColor,
          borderRadius: BorderRadius.circular(_cameraModalButtonRadius),
          border: Border.all(
            width: _cameraModalButtonBorderWith,
            color: context.palette.accentVariantColor,
          ),
        ),
        width: _cameraModalButtonWidth,
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
              color: isCameraButton ? context.palette.cardColor : context.palette.accentVariantColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
