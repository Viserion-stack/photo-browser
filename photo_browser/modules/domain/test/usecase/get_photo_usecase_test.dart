import 'package:domain/data_source_action/get_photo_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:domain/usecase/get_photo_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetPhotoRemoteSourceAction extends Mock implements GetPhotoRemoteSourceAction {}

void main() {
  group(
    'GetPhotoRemoteSourceAction',
    () {
      late MockGetPhotoRemoteSourceAction mockGetPhotoRemoteSourceAction;
      late GetPhotoUsecase getPhotoUsecase;

      setUp(
        () {
          mockGetPhotoRemoteSourceAction = MockGetPhotoRemoteSourceAction();
          getPhotoUsecase = GetPhotoUsecase(
            getPhotoRemoteSourceAction: mockGetPhotoRemoteSourceAction,
          );
        },
      );

      final photoList = [Photo.initial()];
      final getPhotoListSuccessResponse = TaskEither<ErrorDetail, List<Photo>>.right(photoList);
      final getPhotoListFailureResponse = TaskEither<ErrorDetail, List<Photo>>.left(const ErrorDetail.fatal());

      test(
        'Should return list of photos when no error has occured',
        () async {
          when(
            () => mockGetPhotoRemoteSourceAction.execute(),
          ).thenReturn(getPhotoListSuccessResponse);

          final result = await getPhotoUsecase.execute().run();

          result.match(
            (it) => throw it,
            (it) => expect(it, photoList),
          );
        },
      );

      test(
        'Should return fatal error detail when getting current user fails',
        () async {
          when(
            () => mockGetPhotoRemoteSourceAction.execute(),
          ).thenReturn(getPhotoListFailureResponse);

          final result = await getPhotoUsecase.execute().run();

          result.match(
            (it) => expect(it, GetPhotoFailure.fatal),
            (it) => throw it,
          );
        },
      );
    },
  );
}
