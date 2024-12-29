import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:task/core/api/dio_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/failure/failure_model.dart';
import 'package:task/core/domain/task_data.dart';
import 'package:task/core/helpers/level_flags.dart';

class HomeRepo {
  final DioConsumer _dioConsumer;

  HomeRepo({required DioConsumer dioConsumer}) : _dioConsumer = dioConsumer;
  Future<Either<Failure, dynamic>> getTask(String id) async {
    try {
      final response = await _dioConsumer.get(
        "${EndPoints.todos}/$id",
      );
      Map<String, dynamic> res = jsonDecode(response.data);
      DateTime date = DateTime.parse(res["updatedAt"]);
      TaskData taskData = TaskData(
          id: res["_id"],
          title: res["title"],
          description: res["desc"],
          date: "${date.day}/${date.month}/${date.year}",
          flagPoriorty: getLevelFlag(res["priority"]),
          status: getItemStatus(res["status"]));
      return Right(taskData);
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }
      return Left(Failure(id: 0, message: "Something went wrong"));
    }
  }

  Future<Either<Failure, dynamic>> fetchHomeData(int page) async {
    try {
      final response = await _dioConsumer.get(
        EndPoints.todos,
        queryParameters: {
          "page": page,
        },
      );

      List res = jsonDecode(response.data);

      List<TaskData> tasks = res.map((e) {
        DateTime date = DateTime.parse(e["updatedAt"]);
        return TaskData(
            id: e["_id"],
            title: e["title"],
            description: e["desc"],
            date: "${date.day}/${date.month}/${date.year}",
            flagPoriorty: getLevelFlag(e["priority"]),
            status: getItemStatus(e["status"]));
      }).toList();

      return Right(tasks);
    } catch (error) {
      if (error is Failure) {
        return Left(error);
      }
      return Left(Failure(id: 0, message: "Something went wrong"));
    }
  }
}

levelFlag getLevelFlag(String level) {
  switch (level) {
    case "low":
      return levelFlag.LOW;
    case "medium":
      return levelFlag.MEDIUM;
    case "high":
      return levelFlag.HEIGH;
    default:
      return levelFlag.LOW;
  }
}

ItemStatus getItemStatus(String status) {
  switch (status) {
    case "finished":
      return ItemStatus.FINISHED;
    case "waiting":
      return ItemStatus.WAITING;
    case "inptogress":
      return ItemStatus.INPROGRESS;
    default:
      return ItemStatus.WAITING;
  }
}
