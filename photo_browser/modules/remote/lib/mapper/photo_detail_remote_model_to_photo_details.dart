import 'package:domain/model/photo_details.dart';
import 'package:domain/model/photo_location.dart';
import 'package:domain/model/photo_urls.dart';
import 'package:domain/model/photographer.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo_details/photo_details_remote_model.dart';
import 'package:remote/models/photo_location/photo_location_remote_model.dart';
import 'package:remote/models/photo_urls/photo_urls_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';

class PhotoDetailsRemoteModelToPhotoDetails implements Mapper<PhotoDetailsRemoteModel, PhotoDetails> {
  const PhotoDetailsRemoteModelToPhotoDetails({
    required Mapper<PhotoLocationRemoteModel, PhotoLocation> photoLocationRemoteModelToPhotoLocation,
    required Mapper<PhotoUrlsRemoteModel, PhotoUrls> photoUrlsRemoteModelToPhotoUrls,
    required Mapper<PhotographerRemoteModel, Photographer> photographerRemoteModelToPhotographer,
  })  : _photoLocationRemoteModelToPhotoLocation = photoLocationRemoteModelToPhotoLocation,
        _photoUrlsRemoteModelToPhotoUrls = photoUrlsRemoteModelToPhotoUrls,
        _photographerRemoteModelToPhotographer = photographerRemoteModelToPhotographer;

  final Mapper<PhotoLocationRemoteModel, PhotoLocation> _photoLocationRemoteModelToPhotoLocation;
  final Mapper<PhotoUrlsRemoteModel, PhotoUrls> _photoUrlsRemoteModelToPhotoUrls;
  final Mapper<PhotographerRemoteModel, Photographer> _photographerRemoteModelToPhotographer;

  @override
  PhotoDetails map(PhotoDetailsRemoteModel element) {
    return PhotoDetails(
        id: element.id,
        urls: _photoUrlsRemoteModelToPhotoUrls.map(element.urls),
        user: _photographerRemoteModelToPhotographer.map(element.user),
        location: _photoLocationRemoteModelToPhotoLocation.map(element.location),
        likes: element.likes,
        description: element.description);
  }
}
