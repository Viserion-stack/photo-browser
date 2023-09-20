import 'package:domain/data_source_action/search_photos_remote_source_action.dart';
import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:domain/model/search_photos_request.dart';
import 'package:domain/usecase/search_photos_usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSearchPhotosRemoteSourceAction extends Mock implements SearchPhotosRemoteSourceAction {}

void main() {
  group(
    'SearchPhotosRemoteSourceAction',
    () {
      late MockSearchPhotosRemoteSourceAction mockSearchPhotosRemoteSourceAction;
      late SearchPhotosUsecase searchPhotosUsecase;

      setUp(
        () {
          mockSearchPhotosRemoteSourceAction = MockSearchPhotosRemoteSourceAction();
          searchPhotosUsecase = SearchPhotosUsecase(searchPhotosRemoteSourceAction: mockSearchPhotosRemoteSourceAction);
        },
      );

      final searchPhotosRequest = SearchPhotosRequest(
        query: 'query',
        page: 1,
      );

      final photosList = [Photo.initial()];

      final searchPhotosListSuccessResponse = TaskEither<ErrorDetail, List<Photo>>.right(photosList);
      final searchPhotosListFailureResponse = TaskEither<ErrorDetail, List<Photo>>.left(const ErrorDetail.fatal());

      test(
        'Should return list of photos when no error has occured',
        () async {
          when(
            () => mockSearchPhotosRemoteSourceAction.execute(searchPhotosRequest.query, searchPhotosRequest.page),
          ).thenReturn(searchPhotosListSuccessResponse);

          final result = await searchPhotosUsecase.execute(param: searchPhotosRequest).run();

          result.match(
            (it) => throw it,
            (it) => expect(it, photosList),
          );
        },
      );

      test(
        'Should return fatal error when searching photos fails',
        () async {
          when(
            () => mockSearchPhotosRemoteSourceAction.execute(searchPhotosRequest.query, searchPhotosRequest.page),
          ).thenReturn(searchPhotosListFailureResponse);

          final result = await searchPhotosUsecase.execute(param: searchPhotosRequest).run();

          result.match(
            (it) => expect(it, SearchPhotosFailure.fatal),
            (it) => throw it,
          );
        },
      );
    },
  );
}
