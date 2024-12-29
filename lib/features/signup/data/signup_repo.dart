import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/api/failure_types.dart';
import 'package:task/core/failure/failure_model.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';

class SignupRepo {
  final DioConsumer _dioConsumer;
  final SecureStorage storage;

  SignupRepo({required this.storage, required DioConsumer dioConsumer})
      : _dioConsumer = dioConsumer;

  Future<Either<Failure, dynamic>> signup(
      {required String phone,
      required String password,
      required String name,
      required int experinceYears,
      required String level,
      required String address}) async {
    try {
      final response = await _dioConsumer.post(
        EndPoints.register,
        body: {
          "phone": phone.trim(),
          "password": password.trim(),
          "displayName": name,
          "experienceYears": experinceYears,
          "address": address,
          "level": level.trim()
        },
      );

      storage.setAccessToken(response["access_token"]);
      storage.setRefreshToken(response["refresh_token"]);
      storage.setUserId(response["_id"]);

      return Right(response);
    } catch (error) {
      if (error is Failure) {
        if (error is UnAuthorizedFailure) {
          return Left(Failure(id: 111, message: "Signup failed"));
        }
        return Left(error);
      }
      rethrow;
    }
  }
}
