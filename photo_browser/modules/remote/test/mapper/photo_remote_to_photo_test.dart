import 'package:domain/model/photo.dart';
import 'package:domain/model/photographer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/mapper/photo_remote_to_photo_mapper.dart';
import 'package:remote/mapper/photographer_remote_to_photographer_mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';
import 'package:test/test.dart';

class MockPhotographerRemoteToPhotographerMapper extends Mock implements PhotographerRemoteToPhotographerMapper {}

void main() {
  group(
    'PhotoRemoteToPhotoMapper',
    () {
      late PhotoRemoteToPhotoMapper photoRemoteToPhotoMapper;
      late MockPhotographerRemoteToPhotographerMapper mockPhotographerRemoteToPhotographerMapper;

      setUp(
        () {
          mockPhotographerRemoteToPhotographerMapper = MockPhotographerRemoteToPhotographerMapper();
          photoRemoteToPhotoMapper = PhotoRemoteToPhotoMapper(
            photographerRemoteToPhotographerMapper: mockPhotographerRemoteToPhotographerMapper,
          );
        },
      );

      final photographer = Photographer(
        id: 'id',
        username: 'username',
      );
      const photographerRemote = PhotographerRemoteModel(
        id: 'id',
        username: 'username',
      );
      const photoRemoteModel = PhotoRemoteModel(
        id: 'id',
        urls: {},
        description: 'description',
        user: photographerRemote,
      );
      final photo = Photo(
        id: 'id',
        urls: {},
        description: 'description',
        user: photographer,
      );

      test(
        'should correctly map remote model to domain model',
        () {
          when(
            () => mockPhotographerRemoteToPhotographerMapper.map(photographerRemote),
          ).thenReturn(photographer);

          final result = photoRemoteToPhotoMapper.map(photoRemoteModel);

          expect(result, photo);
        },
      );
    },
  );
}
