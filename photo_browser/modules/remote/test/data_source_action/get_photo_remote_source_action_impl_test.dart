import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:domain/model/photographer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/api/photo_rest_api.dart';
import 'package:remote/data_source_action/get_photo_remote_source_action_impl.dart';
import 'package:remote/mapper/photo_remote_to_photo_mapper.dart';
import 'package:remote/mapper/photographer_remote_to_photographer_mapper.dart';
import 'package:remote/models/photo/photo_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

class MockPhotoRestApi extends Mock implements PhotoRestApi {}

class MockPhotographerRemoteToPhotographerMapper extends Mock implements PhotographerRemoteToPhotographerMapper {}

class MockPhotoRemoteToPhotoMapper extends Mock implements PhotoRemoteToPhotoMapper {}

class MockErrorConverter extends Mock implements ErrorConverter {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeError extends Fake implements Object {}

void main() {
  group(
    'GetPhotoRemoteSourceAction',
    () {
      late MockErrorConverter mockErrorConverter;
      late MockPhotoRestApi mockPhotoRestApi;
      late MockPhotoRemoteToPhotoMapper mockPhotoRemoteToPhotoMapper;
      late MockPhotographerRemoteToPhotographerMapper mockPhotographerRemoteToPhotographerMapper;
      late GetPhotoRemoteSourceActionImpl getPhotoRemoteSourceActioniImpl;

      setUpAll(
        () {
          registerFallbackValue(FakeStackTrace());
          registerFallbackValue(FakeError());
        },
      );

      setUp(
        () {
          mockPhotoRemoteToPhotoMapper = MockPhotoRemoteToPhotoMapper();
          mockPhotoRestApi = MockPhotoRestApi();
          mockPhotographerRemoteToPhotographerMapper = MockPhotographerRemoteToPhotographerMapper();
          mockErrorConverter = MockErrorConverter();

          getPhotoRemoteSourceActioniImpl = GetPhotoRemoteSourceActionImpl(
            photoRestApi: mockPhotoRestApi,
            errorConverter: mockErrorConverter,
            photoRemoteToPhotoMapper: mockPhotoRemoteToPhotoMapper,
          );
        },
      );
      final photographer = Photographer(
        id: 'id',
        username: 'username',
      );
      const photographerRemoteModel = PhotographerRemoteModel(
        id: 'id',
        username: 'username',
      );
      final photo = Photo(
        id: 'id',
        urls: {},
        description: 'description',
        user: photographer,
      );

      const photoRemoteModel = PhotoRemoteModel(
        id: 'id',
        urls: {},
        description: 'description',
        user: photographerRemoteModel,
      );

      final listPhotos = [photo];
      final listPhotosRemote = [photoRemoteModel];

      test(
        'Should return photos when no error has occured',
        () async {
          when(
            () => mockPhotoRemoteToPhotoMapper.map(photoRemoteModel),
          ).thenReturn(photo);
          when(
            () => mockPhotographerRemoteToPhotographerMapper.map(photographerRemoteModel),
          ).thenReturn(photographer);
          when(
            () => mockPhotoRestApi.getPhotos(),
          ).thenAnswer(
            (invocation) async => listPhotosRemote,
          );

          final result = await getPhotoRemoteSourceActioniImpl.execute().run();

          result.match(
            (it) => throw it,
            (it) => expect(it, listPhotos),
          );
        },
      );

      test(
        'Should return fatal error detail when getting photos fails',
        () async {
          when(
            () => mockPhotoRestApi.getPhotos(),
          ).thenThrow(Exception('Error'));
          when(() => mockErrorConverter.handleRemoteError(any(), any())).thenReturn(const ErrorDetail.fatal());

          final result = await getPhotoRemoteSourceActioniImpl.execute().run();

          result.match(
            (it) => expect(it, const ErrorDetail.fatal()),
            (it) => throw it,
          );
        },
      );
    },
  );
}
