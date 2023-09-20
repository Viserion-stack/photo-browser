// ignore_for_file: avoid_classes_with_only_static_members

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/environment/.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_URL')
  static final apiUrl = _Env.apiUrl;
  @EnviedField(varName: 'API_KEY')
  static final apiKey = _Env.apiKey;
  @EnviedField(varName: 'CLIENT_ID')
  static final clientId = _Env.clientId;
}
