import 'package:domain/model/photo_urls.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo_urls/photo_urls_remote_model.dart';

class PhotoUrlsRemoteModelToPhotoUrls implements Mapper<PhotoUrlsRemoteModel, PhotoUrls> {
  const PhotoUrlsRemoteModelToPhotoUrls();

  @override
  PhotoUrls map(PhotoUrlsRemoteModel element) {
    return PhotoUrls(
      raw: element.raw,
      full: element.full,
      small: element.small,
      thumb: element.thumb,
    );
  }
}
