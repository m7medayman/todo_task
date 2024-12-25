import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/features/login/data/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepo repo;

  LoginCubit(this.repo)
      : super(LoginState(
          pageState: InitpageState(),
        ));
  void login(String phoneNumber, String password, String countryCode) {
    if (phoneNumber.length == 11) {
      phoneNumber = phoneNumber.substring(1);
    }
    print(countryCode+phoneNumber);
    emit(state.copyWith(pageState: LoadingPageState()));
    repo.login(countryCode + phoneNumber, password).then((response) {
      response.fold((error) {
        emit(state.copyWith(
            pageState: FailurePageState(errorMessage: error.message)));
      }, (data) {
        emit(state.copyWith(pageState: SuccessPageState()));
      });
    });
  }
}
