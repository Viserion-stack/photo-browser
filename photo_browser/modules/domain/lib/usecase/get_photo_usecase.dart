import 'package:domain/data_source_action/get_photo_remote_source_action.dart';
import 'package:domain/model/photo.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum GetPhotoFailure { fatal }

class GetPhotoUsecase implements UseCase<GetPhotoFailure, List<Photo>> {
  const GetPhotoUsecase({
    required GetPhotoRemoteSourceAction getPhotoRemoteSourceAction,
  }) : _getPhotoRemoteSourceAction = getPhotoRemoteSourceAction;

  final GetPhotoRemoteSourceAction _getPhotoRemoteSourceAction;

  @override
  TaskEither<GetPhotoFailure, List<Photo>> execute() {
    return _getPhotoRemoteSourceAction.execute().bimap(
          (errorDetail) => errorDetail.map(
            backend: (backendError) {
              switch (backendError.errorCode) {
                default:
                  return GetPhotoFailure.fatal;
              }
            },
            fatal: (fatalError) => GetPhotoFailure.fatal,
          ),
          (r) => r,
        );
  }
}
