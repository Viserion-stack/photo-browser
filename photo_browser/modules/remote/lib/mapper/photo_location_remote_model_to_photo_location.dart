import 'package:domain/model/photo_location.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo_location/photo_location_remote_model.dart';

class PhotoLocationRemoteModelToPhotoLocation implements Mapper<PhotoLocationRemoteModel, PhotoLocation> {
  const PhotoLocationRemoteModelToPhotoLocation();

  @override
  PhotoLocation map(PhotoLocationRemoteModel element) {
    return PhotoLocation(
      city: element.city,
      country: element.country,
    );
  }
}
