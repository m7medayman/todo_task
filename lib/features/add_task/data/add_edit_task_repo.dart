import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/failure/failure_model.dart';

class AddEditTaskRepo {
  final DioConsumer _dioConsumer;

  AddEditTaskRepo({required DioConsumer dioConsumer})
      : _dioConsumer = dioConsumer;

  Future<Either<Failure, dynamic>> addTask(
      String title, String desc, String priority, String dueDate) async {
    try {
      final taskData = {
        "image": "imagePath",
        "title": title,
        "desc": desc,
        "priority": priority,
        "dueDate": dueDate,
      };

      final response = await _dioConsumer.post(
        EndPoints.todos,
        body: taskData,
      );

      return Right(response);
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }
      print(error.toString());
      return Left(Failure(id: 0, message: "Something went wrong"));
    }
  }

  Future<Either<Failure, dynamic>> editTask(
      {
        required String id,
   required   String title,
    required  String desc,
    required  String priority,
    required String status,
     required String userId}) async {
    try {
      final taskData = {
        "image": "imagePath.png",
        "title": title,
        "desc": desc,
        "priority": priority,
        "status": status,
        "user": userId
      };

      final response = await _dioConsumer.put(
        "${EndPoints.todos}/$id",
        body: taskData,
      );

      return Right(response.data);
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }
      return Left(Failure(id: 0, message: "Something went wrong"));
    }
  }
}
