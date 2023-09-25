import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo_details.dart';
import 'package:domain/model/photo_location.dart';
import 'package:domain/model/photo_urls.dart';
import 'package:domain/model/photographer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/api/photo_rest_api.dart';
import 'package:remote/data_source_action/get_photo_details_remote_source_action_impl.dart';
import 'package:remote/mapper/photo_detail_remote_model_to_photo_details.dart';
import 'package:remote/models/photo_details/photo_details_remote_model.dart';
import 'package:remote/models/photo_location/photo_location_remote_model.dart';
import 'package:remote/models/photo_urls/photo_urls_remote_model.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';
import 'package:remote/other/error/error_converter.dart';
import 'package:test/test.dart';

class MockPhotoRestApi extends Mock implements PhotoRestApi {}

class MockPhotoDetailsRemoteModelToPhotoDetails extends Mock implements PhotoDetailsRemoteModelToPhotoDetails {}

class MockErrorConverter extends Mock implements ErrorConverter {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeError extends Fake implements Object {}

void main() {
  group(
    'GetPhotoDetailsRemoteSourceAction',
    () {
      late MockErrorConverter mockErrorConverter;
      late MockPhotoDetailsRemoteModelToPhotoDetails mockPhotoDetailsRemoteModelToPhotoDetails;

      late MockPhotoRestApi mockPhotoRestApi;
      late GetPhotoDetailsRemoteSourceActionImpl getPhotoDetailsRemoteSourceActionImpl;

      setUpAll(
        () {
          registerFallbackValue(FakeStackTrace());
          registerFallbackValue(FakeError());
        },
      );

      setUp(
        () {
          mockPhotoRestApi = MockPhotoRestApi();
          mockErrorConverter = MockErrorConverter();
          mockPhotoDetailsRemoteModelToPhotoDetails = MockPhotoDetailsRemoteModelToPhotoDetails();
          getPhotoDetailsRemoteSourceActionImpl = GetPhotoDetailsRemoteSourceActionImpl(
            errorConverter: mockErrorConverter,
            photoDetailsRemoteToPhotoDetails: mockPhotoDetailsRemoteModelToPhotoDetails,
            photoRestApi: mockPhotoRestApi,
          );
        },
      );

      final photoUrls = PhotoUrls(
        raw: 'raw',
        full: 'full',
        small: 'small',
        thumb: 'thumb',
      );
      final photoLocation = PhotoLocation(
        city: 'city',
        country: 'country',
      );
      final user = Photographer(
        id: 'id',
        username: 'username',
      );

      final photoDetails = PhotoDetails(
        id: 'id',
        urls: photoUrls,
        user: user,
        location: photoLocation,
        likes: 1,
        description: 'description',
      );

      const photoLocationRemote = PhotoLocationRemoteModel(
        city: 'city',
        country: 'country',
      );
      const userRemote = PhotographerRemoteModel(
        id: 'id',
        username: 'username',
      );
      const photoUrlsRemote = PhotoUrlsRemoteModel(
        raw: 'raw',
        full: 'full',
        small: 'small',
        thumb: 'thumb',
      );

      const photoDetailsRemoteModel = PhotoDetailsRemoteModel(
        id: 'id',
        urls: photoUrlsRemote,
        location: photoLocationRemote,
        user: userRemote,
        likes: 1,
      );

      test(
        'Should return photo details when no error has occured',
        () async {
          when(
            () => mockPhotoRestApi.getPhotoDetails(id: 'id'),
          ).thenAnswer((_) async => photoDetailsRemoteModel);
          when(
            () => mockPhotoDetailsRemoteModelToPhotoDetails.map(photoDetailsRemoteModel),
          ).thenReturn(photoDetails);

          final result = await getPhotoDetailsRemoteSourceActionImpl.execute(id: 'id').run();

          result.match(
            (it) => throw it,
            (it) => expect(it, photoDetails),
          );
        },
      );

      test(
        'Should return fatal error when getting photo details fails',
        () async {
          when(
            () => mockPhotoRestApi.getPhotoDetails(id: 'id'),
          ).thenThrow(Exception('Error'));
          when(() => mockErrorConverter.handleRemoteError(any(), any())).thenReturn(const ErrorDetail.fatal());

          final result = await getPhotoDetailsRemoteSourceActionImpl.execute(id: 'id').run();

          result.match(
            (it) => expect(it, const ErrorDetail.fatal()),
            (it) => throw it,
          );
        },
      );
    },
  );
}
