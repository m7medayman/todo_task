import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/api/failure_types.dart';
import 'package:task/core/failure/failure_model.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';

class LoginRepo {
  final DioConsumer _dioConsumer;
  final SecureStorage storage;

  LoginRepo({required this.storage, required DioConsumer dioConsumer})
      : _dioConsumer = dioConsumer;

  Future<Either<Failure, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dioConsumer.post(
        EndPoints.login,
        body: {
          "phone": phone.trim(),
          "password": password.trim(),
        },
      );

      storage.setAccessToken(response["access_token"]);
      storage.setRefreshToken(response["refresh_token"]);

      return Right(response);
    } catch (error) {
      if (error is Failure) {
        if (error is UnAuthorizedFailure) {
          return Left(Failure(id: 111,message: "Wrong phone or password"));
        }
        return Left(error);
      }
      rethrow;
    }
  }
}
