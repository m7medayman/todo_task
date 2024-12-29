import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/failure/failure_model.dart';
import 'package:task/features/profile/domain/user_data.dart';

class ProfileRepo {
  final DioConsumer _dioConsumer;

  ProfileRepo({required DioConsumer dioConsumer}) : _dioConsumer = dioConsumer;
  Future<Either<Failure, UserProfileData>> getUser() async {
    try {
      final response = await _dioConsumer.get(EndPoints.profile);
      Map<String, dynamic> res = jsonDecode(response.data);

      UserProfileData userData = UserProfileData(
          name: res["displayName"],
          phone: res["username"],
          level: res["level"],
          yearsOfExperience: res["experienceYears"].toString(),
          location: res["address"]);
      return Right(userData);
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }
      return Left(Failure(id: 0, message: "Something went wrong"));
    }
  }
}
