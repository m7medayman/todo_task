import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task/core/common/widget/status_container.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/secure_storage/secure_stroage.dart';
import 'package:task/features/delete_task/delete_task_api.dart';
import 'package:task/features/home/data/home_repo.dart';
import 'package:task/core/domain/task_data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo, this.deleteTaskRepo, this.secureStorage)
      : super(HomeState(
            currentPage: 1,
            pageState: InitpageState(),
            tasks: [],
            filterdTask: []));
  final HomeRepo repo;
  final DeleteTaskRepo deleteTaskRepo;
  final SecureStorage secureStorage;
  void reset() {
    emit(state.copyWith(
      currentPage: 1,
      tasks: [],
      filterdTask: [],
    ));
  }

  void logOut() {
    secureStorage.clearStorage();
  }

  void deleteTaks(String id) async {
    emit(state.copyWith(pageState: LoadingPageState()));
    var res = await deleteTaskRepo.deleteTask(id).fold((error) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: error.message)));
      emit(state.copyWith(pageState: InitpageState()));
    }, (success) {
      List<TaskData> newtasks = List.from(state.tasks);
      newtasks.removeWhere((task) => task.id == id);
      emit(state.copyWith(pageState: SuccessPageState(), tasks: newtasks));
      setAllFilter();
      emit(state.copyWith(pageState: InitpageState()));
    });
  }

  void qrTaske(String id) async {
    emit(state.copyWith(pageState: LoadingPageState()));
    var res = await repo.getTask(id);
    res.fold((error) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: error.message)));
      emit(state.copyWith(pageState: InitpageState()));
    }, (task) {
      emit(state.copyWith(pageState: InitpageState()));
      emit(state.copyWith(pageState: QRTaskPageState(data: task)));
    });
  }

  void setAllFilter() {
    emit(state.copyWith(
        all: true, inProgress: false, waiting: false, finished: false));
    setFilteredList();
  }

  void setInProgressFilter() {
    emit(state.copyWith(
        all: false, inProgress: true, waiting: false, finished: false));
    setFilteredList();
  }

  void setWaitingFilter() {
    emit(state.copyWith(
        all: false, inProgress: false, waiting: true, finished: false));
    setFilteredList();
  }

  void setFinishedFilter() {
    emit(state.copyWith(
        all: false, inProgress: false, waiting: false, finished: true));
    setFilteredList();
  }

  void setFilteredList() {
    List<TaskData> filterdTasks = [];
    if (state.all) {
      filterdTasks = state.tasks;
    } else if (state.inProgress) {
      filterdTasks = state.tasks.where((element) {
        if (element.status == ItemStatus.INPROGRESS) {
          print(element.status);
        }
        return element.status == ItemStatus.INPROGRESS;
      }).toList();
    } else if (state.waiting) {
      filterdTasks = state.tasks.where((element) {
        print(element.status);
        if (element.status == ItemStatus.WAITING) {
          print(element.status);
        }
        return element.status == ItemStatus.WAITING;
      }).toList();
    } else if (state.finished) {
      filterdTasks = state.tasks
          .where((element) => element.status == ItemStatus.FINISHED)
          .toList();
    }
    ;
    print(filterdTasks);
    emit(state.copyWith(filterdTask: filterdTasks));
  }

  void updateHomeData() async {
    emit(state.copyWith(pageState: LoadingHomePageState()));
    await repo.fetchHomeData(state.currentPage).then((response) {
      response.fold((error) {
        emit(state.copyWith(
            pageState: FailurePageState(errorMessage: error.message)));
      }, (data) {
        int page = state.currentPage;
        print(data);
        List<TaskData> newTasks = List.from(state.tasks);
        data as List<TaskData>;
        if (data.isNotEmpty) {
          state.tasks;
          newTasks = newTasks + data;
          page++;
        }

        emit(state.copyWith(
            currentPage: page, pageState: SuccessPageState(), tasks: newTasks));
        setFilteredList();
      });
    });
  }
}
