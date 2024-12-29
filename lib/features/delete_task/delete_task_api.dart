import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/failure/failure_model.dart';

class DeleteTaskRepo {
  final DioConsumer _dioConsumer;

  DeleteTaskRepo({required DioConsumer dioConsumer})
      : _dioConsumer = dioConsumer;

  Future<Either<Failure, dynamic>> deleteTask(String id) async {
    try {
      final response = await _dioConsumer.delete(
        "${EndPoints.todos}/$id",
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
