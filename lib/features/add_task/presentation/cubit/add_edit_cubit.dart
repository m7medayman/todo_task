import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/core/di/di.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';
import 'package:task/features/add_task/data/add_edit_task_repo.dart';

part 'add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
  AddEditTaskRepo repo;
  SecureStorage secureStorage;
  AddEditCubit(this.repo,this.secureStorage)
      : super(AddEditState(isEdit: false, pageState: InitpageState()));
  void changeEditState(bool isEdit, String id) {
    emit(AddEditState(isEdit: isEdit, pageState: InitpageState(), id: id));
  }

  void submitButton(
      String title, String desc, String priority, String dueDateOrStatus) {
    emit(state.copyWith(pageState: LoadingPageState()));
    if (state.isEdit) {
      editTask(state.id!, title, desc, priority, dueDateOrStatus);
      return;
    }

    addTask(title, desc, priority, dueDateOrStatus);
  }

  void addTask(
      String title, String desc, String priority, String dueDate) async {
    var res = await repo.addTask(title, desc, priority, dueDate);
    res.fold((failure) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: failure.message)));
    }, (data) {
      emit(state.copyWith(pageState: SuccessPageState()));
    });
  }

  void editTask(String id, String title, String desc, String priority,
      String status) async {
    var res = await repo.editTask(
        id: id,
        title: title,
        desc: desc,
        priority: priority,
        status: status,
        userId:await secureStorage.getUserId()??"");
    res.fold((failure) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: failure.message)));
    }, (data) {
      emit(state.copyWith(pageState: SuccessPageState()));
    });
  }
}
