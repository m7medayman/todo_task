import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/common/widget/status_flag.dart';
import 'package:task/core/helpers/level_flags.dart';

class TaskData {
  final String id;
  final String title;
  final String description;
  final String date;
  final levelFlag flagPoriorty;
  final ItemStatus status;
  TaskData(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.flagPoriorty,
      required this.status});
}
