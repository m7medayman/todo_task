part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool all;
  final bool inProgress;
  final bool waiting;
  final bool finished;
  final PageState pageState;
  final List<TaskData> tasks;
  final List<TaskData> filterdTask;
  final int currentPage;

  const HomeState({
    required this.currentPage,
    required this.pageState,
    required this.tasks,
    required this.filterdTask,
    this.all = true,
    this.inProgress = false,
    this.waiting = false,
    this.finished = false,
  });

  HomeState copyWith({
    bool? all,
    bool? inProgress,
    bool? waiting,
    bool? finished,
    int? currentPage,
    PageState? pageState,
    List<TaskData>? tasks,
    List<TaskData>? filterdTask,
  }) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
      tasks: tasks ?? this.tasks,
      filterdTask: filterdTask ?? this.filterdTask,
      pageState: pageState ?? this.pageState,
      all: all ?? this.all,
      inProgress: inProgress ?? this.inProgress,
      waiting: waiting ?? this.waiting,
      finished: finished ?? this.finished,
    );
  }

  @override
  List<Object> get props => [
        currentPage,
        pageState,
        all,
        inProgress,
        waiting,
        finished,
        filterdTask,
        tasks
      ];
}

class QRTaskPageState extends PageState {
  final TaskData data;

  QRTaskPageState({required this.data});
}
