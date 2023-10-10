import 'package:image_picker/image_picker.dart';

const _imageQuality = 90;
const _maxHeight = 500.0;
const _maxWidth = 500.0;

Future<XFile?> usePhotoBrowserImagePicker() => ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: _imageQuality,
      maxHeight: _maxHeight,
      maxWidth: _maxWidth,
    );

Future<XFile?> usePhotoBrowserCamera() => ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: _imageQuality,
      maxHeight: _maxHeight,
      maxWidth: _maxWidth,
    );
