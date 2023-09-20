// ignore_for_file: avoid_classes_with_only_static_members

import 'package:dio/dio.dart';
import 'package:domain/auth_token_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class DioProvider {
  static String dioAuth = 'DioAuth';
  static String dioNoAuth = 'DioNoAuth';

  static Dio create({
    required String baseUrl,
    required String clientId,
    required AuthTokenProvider authTokenProvider,
    required PrettyDioLogger prettyDioLogger,
    required bool addAuthorizationInterceptor,
  }) {
    final dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.responseType = ResponseType.json
      ..options.headers.addAll({'Authorization': 'Client-ID $clientId'});

    if (!kReleaseMode) {
      dio.interceptors.add(prettyDioLogger);
    }

    if (addAuthorizationInterceptor) {
      dio.interceptors.add(_authorizationInterceptor(authTokenProvider, clientId));
    }

    return dio;
  }

  static InterceptorsWrapper _authorizationInterceptor(AuthTokenProvider authTokenProvider, String clientId) {
    return InterceptorsWrapper(
      onRequest: (options, interceptorHandler) async {
        final token = await authTokenProvider.token;
        if (token.isNotEmpty) {
          options.headers.addAll(
            {
              'contentType': 'application/json',
            },
          );
        }
        interceptorHandler.next(options);
      },
    );
  }
}
