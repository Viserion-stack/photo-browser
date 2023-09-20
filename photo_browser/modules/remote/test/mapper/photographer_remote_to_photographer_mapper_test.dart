import 'package:domain/model/photographer.dart';
import 'package:remote/mapper/photographer_remote_to_photographer_mapper.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';
import 'package:test/test.dart';

void main() {
  group(
    'PhotographerRemoteToPhotographerMapper',
    () {
      late PhotographerRemoteToPhotographerMapper photographerRemoteToPhotographerMapper;

      setUp(
        () {
          photographerRemoteToPhotographerMapper = const PhotographerRemoteToPhotographerMapper();
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

      test(
        'should correcty map remote model to domain model',
        () {
          final result = photographerRemoteToPhotographerMapper.map(photographerRemote);

          expect(result, photographer);
        },
      );
    },
  );
}
