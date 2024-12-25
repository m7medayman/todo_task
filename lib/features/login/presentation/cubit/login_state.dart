part of 'login_cubit.dart';

@immutable
 class LoginState {
  final PageState pageState;

  const LoginState({required this.pageState,});
//copy with method
  LoginState copyWith({
    PageState? pageState,
    String? phoneNumber,
    String? password,
  }) {
    return LoginState(
      pageState: pageState ?? this.pageState,
     
    );
  }
}
