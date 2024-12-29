import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/features/delete_task/delete_task_api.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  final DeleteTaskRepo deleteTaskRepo;
  TaskDetailsCubit({required this.deleteTaskRepo})
      : super(TaskDetailsState(pageState: InitpageState()));
  void deleteTaks(String id) async {
    emit(state.copyWith(pageState: LoadingPageState()));
    var res = await deleteTaskRepo.deleteTask(id).fold((error) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: error.message)));
      emit(state.copyWith(pageState: InitpageState()));
    }, (success) {
      emit(state.copyWith(pageState: SuccessPageState()));
    });
  }
}
