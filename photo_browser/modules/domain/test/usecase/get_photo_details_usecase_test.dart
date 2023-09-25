import 'package:domain/data_source_action/get_photo_details_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo_details.dart';
import 'package:domain/model/photo_location.dart';
import 'package:domain/model/photo_urls.dart';
import 'package:domain/model/photographer.dart';
import 'package:domain/usecase/get_photo_details_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetPhotoDetailsRemoteSourceAction extends Mock implements GetPhotoDetailsRemoteSourceAction {}

void main() {
  group(
    'GetPhotoDetailsRemoteSourceAction',
    () {
      late MockGetPhotoDetailsRemoteSourceAction mockGetPhotoDetailsRemoteSourceAction;
      late GetPhotoDetailsUsecase getPhotoDetailsUsecase;

      setUp(
        () {
          mockGetPhotoDetailsRemoteSourceAction = MockGetPhotoDetailsRemoteSourceAction();
          getPhotoDetailsUsecase = GetPhotoDetailsUsecase(
            getPhotoDetailsRemoteSourceAction: mockGetPhotoDetailsRemoteSourceAction,
          );
        },
      );

      const id = 'id';

      final photoUrls = PhotoUrls(
        raw: 'raw',
        full: 'full',
        small: 'small',
        thumb: 'thumb',
      );
      final user = Photographer(
        id: 'id',
        username: 'username',
      );
      final location = PhotoLocation(
        city: 'city',
        country: 'country',
      );
      final photoDetails = PhotoDetails(
        id: 'id',
        urls: photoUrls,
        user: user,
        location: location,
        likes: 1,
      );

      final getPhotoDetailsSuccesResponse = TaskEither<ErrorDetail, PhotoDetails>.right(photoDetails);
      final getPhotoDetailsFailureResponse = TaskEither<ErrorDetail, PhotoDetails>.left(const ErrorDetail.fatal());

      test(
        'Should return photo details when no error has occured',
        () async {
          when(
            () => mockGetPhotoDetailsRemoteSourceAction.execute(id: id),
          ).thenReturn(getPhotoDetailsSuccesResponse);

          final result = await getPhotoDetailsUsecase.execute(param: id).run();

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
            () => mockGetPhotoDetailsRemoteSourceAction.execute(id: id),
          ).thenReturn(getPhotoDetailsFailureResponse);

          final result = await getPhotoDetailsUsecase.execute(param: id).run();

          result.match(
            (it) => expect(it, GetPhotoDetailsFailure.fatal),
            (it) => throw it,
          );
        },
      );
    },
  );
}
