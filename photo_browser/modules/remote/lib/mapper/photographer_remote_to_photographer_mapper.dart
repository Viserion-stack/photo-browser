import 'package:domain/model/photographer.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/photographer/photographer_remote_model.dart';

class PhotographerRemoteToPhotographerMapper implements Mapper<PhotographerRemoteModel, Photographer> {
  const PhotographerRemoteToPhotographerMapper();

  @override
  Photographer map(PhotographerRemoteModel element) {
    return Photographer(
      id: element.id,
      username: element.username,
    );
  }
}
