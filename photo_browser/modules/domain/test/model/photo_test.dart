import 'package:domain/model/photo.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Photo',
    () {
      final photo = Photo.initial().copyWith(urls: {'key': 'cos'});

      test(
        'should create user model from Json',
        () async {
          final jsonMap = <String, dynamic>{
            'id': 'id',
            'urls': {'key': 'cos'},
            'description': 'description',
          };
          final result = Photo.fromJson(jsonMap);

          expect(result, photo);
        },
      );
    },
  );
}
