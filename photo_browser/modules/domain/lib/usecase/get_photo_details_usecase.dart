import 'package:domain/data_source_action/get_photo_details_remote_source_action.dart';
import 'package:domain/model/photo_details.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

enum GetPhotoDetailsFailure { fatal }

class GetPhotoDetailsUsecase implements ParamUseCase<GetPhotoDetailsFailure, PhotoDetails, String> {
  const GetPhotoDetailsUsecase({required GetPhotoDetailsRemoteSourceAction getPhotoDetailsRemoteSourceAction})
      : _getPhotoDetailsRemoteSourceAction = getPhotoDetailsRemoteSourceAction;

  final GetPhotoDetailsRemoteSourceAction _getPhotoDetailsRemoteSourceAction;

  @override
  TaskEither<GetPhotoDetailsFailure, PhotoDetails> execute({required String param}) {
    return _getPhotoDetailsRemoteSourceAction.execute(id: param).bimap(
          (errorDetail) => errorDetail.map(
            backend: (backendError) {
              switch (backendError.errorCode) {
                default:
                  return GetPhotoDetailsFailure.fatal;
              }
            },
            fatal: (fatalError) => GetPhotoDetailsFailure.fatal,
          ),
          (r) => r,
        );
  }
}
