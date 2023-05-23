import 'package:domain/model/photo.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';

class PhotoRemoteToPhotoMapper implements Mapper<List<PhotoRemoteModel>, List<Photo>> {
  const PhotoRemoteToPhotoMapper();

  @override
  List<Photo> map(List<PhotoRemoteModel> element) {
    final photoList = element
        .map(
          (e) => Photo(
            id: e.id,
            urls: e.urls,
            description: e.description,
          ),
        )
        .toList();
    return photoList;
  }
}
