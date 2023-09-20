import 'package:domain/model/photo.dart';
import 'package:domain/model/photographer.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';

class PhotoRemoteToPhotoMapper implements Mapper<PhotoRemoteModel, Photo> {
  const PhotoRemoteToPhotoMapper({
    required Mapper<PhotographerRemoteModel, Photographer> photographerRemoteToPhotographerMapper,
  }) : _photographerRemoteToPhotographerMapper = photographerRemoteToPhotographerMapper;
  final Mapper<PhotographerRemoteModel, Photographer> _photographerRemoteToPhotographerMapper;

  @override
  Photo map(PhotoRemoteModel element) {
    return Photo(
      id: element.id,
      urls: element.urls,
      description: element.description,
      user: element.user != null ? _photographerRemoteToPhotographerMapper.map(element.user!) : null,
      likes: element.likes,
    );
  }
}
