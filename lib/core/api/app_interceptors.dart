import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';

class MyAppInterceptors extends Interceptor {
  final Dio client;
  final SecureStorage storage;
  // final AuthLocalDataSource authLocalDataSource;
  MyAppInterceptors(this.storage,
      {
      // required this.authLocalDataSource,
      required this.client});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers[HttpHeaders.acceptHeader] = ContentType.json;

    String? authenticatedUserToken = await storage.getAccessToken();
    if (authenticatedUserToken != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer $authenticatedUserToken";
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      String? authenticatedUser = await storage.getAccessToken();
      if (authenticatedUser != null) {
        if (await _refreshToken()) {
          return handler.resolve(await _retry(err.requestOptions));
        }
      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final String newAccessToken = await storage.getAccessToken() ?? "";
    // Clone headers and replace Authorization if it exists
    final headers = Map<String, dynamic>.from(requestOptions.headers);
    headers["Authorization"] = "Bearer $newAccessToken";
    final options = Options(
      method: requestOptions.method,
      headers: headers,
    );
    return client.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> _refreshToken() async {
    final String authToken = await storage.getAccessToken() ?? "";
    final String refreshToken = await storage.getRefreshToken() ?? "";
    if (authToken.isEmpty || refreshToken.isEmpty) {
      return false;
    }
    final response = await client.get(
      EndPoints.refreshToken,
      queryParameters: {
        "token": refreshToken, // Pass the token as a query parameter
      },
      options: Options(
        headers: {
          "Authorization":
              "Bearer $authToken", // Include Bearer token in the header
        },
      ),
    );
    final jsonResponse = response.data;

    if (response.statusCode == 200) {
      storage.setAccessToken(jsonResponse["access_token"]);
      storage.setRefreshToken(jsonResponse["refresh_token"]);

      return true;
    } else {
      return false;
    }
  }
}
