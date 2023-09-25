import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo_details.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetPhotoDetailsRemoteSourceAction {
  TaskEither<ErrorDetail, PhotoDetails> execute({required String id});
}
