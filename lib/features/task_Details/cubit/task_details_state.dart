part of 'task_details_cubit.dart';

class TaskDetailsState extends Equatable {
  const TaskDetailsState({required this.pageState});
  final PageState pageState;

  TaskDetailsState copyWith({PageState? pageState}) {
    return TaskDetailsState(pageState: pageState ?? this.pageState);
  }

  @override
  List<Object> get props => [pageState];
}
