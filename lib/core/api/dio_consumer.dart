import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:task/core/api/failure_types.dart';
import 'package:task/core/failure/failure_model.dart';

import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;
  final MyAppInterceptors appIntercepters;
  final LogInterceptor logInterceptor;

  DioConsumer(
      {required this.logInterceptor,
      required this.appIntercepters,
      required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      return HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false;
    client.interceptors.add(appIntercepters);
    if (kDebugMode) {
      client.interceptors.add(logInterceptor);
    }
  }

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      bool responseIsParsing = true,
      Map<String, String>? headers}) async {
    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      bool responseIsParsing = false,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          data: formDataIsEnabled ? FormData.fromMap(body!) : body,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters);

      // Extract and parse the response body
      print(response.toString());
      return jsonDecode(response.toString()) as Map<String, dynamic>;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      bool responseIsParsing = true,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.delete(path,
          data: body,
          options: Options(
            headers: headers,
          ),
          queryParameters: queryParameters);
      return response;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(String path,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      bool responseIsParsing = true,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );

      return response;
    } on DioException catch (error) {
      throw _handleDioError(error);
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return FailureType.timeout.failure;
      case DioExceptionType.sendTimeout:
        return FailureType.timeout.failure;
      case DioExceptionType.receiveTimeout:
        return FailureType.timeout.failure;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.notFound:
            return FailureType.notFound.failure;
          case StatusCode.conflict:
            return FailureType.conflict.failure;
          case StatusCode.internalServerError:
            return FailureType.internalServerError.failure;
          case StatusCode.unauthorized:
            return FailureType.unAuthorized.failure;
          default:
            return UnknownFailure(message: error.message ?? "");
        }
      case DioExceptionType.cancel:
        return FailureType.cancel.failure;
      case DioExceptionType.unknown:
        return FailureType.noInternetConnection.failure;
      default:
        return UnknownFailure(message: error.message ?? "");
    }
  }
}
