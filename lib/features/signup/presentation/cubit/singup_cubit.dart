import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/features/signup/data/signup_repo.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SignupRepo repo;
  SingupCubit(this.repo) : super(SingupState(pageState: InitpageState()));
// signup method
  void signUP(
      {required String name,
      required String phone,
      required String password,
      required String yearsOfExperince,
      required String adress,
      required String level}) async {
    emit(state.copyWith(pageState: LoadingPageState()));
    await repo
        .signup(
            phone: phone,
            name: name,
            password: password,
            experinceYears: int.parse(yearsOfExperince),
            address: adress,
            level: level)
        .fold((failure) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: failure.message)));
    }, (data) {
      emit(state.copyWith(pageState: SuccessPageState()));
    });
  }
}
