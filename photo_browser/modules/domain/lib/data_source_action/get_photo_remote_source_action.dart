import 'package:domain/model/error_detail.dart';
import 'package:domain/model/photo.dart';
import 'package:fpdart/fpdart.dart';

abstract class GetPhotoRemoteSourceAction {
  TaskEither<ErrorDetail, List<Photo>> execute();
}
