import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/features/profile/data/profile_repo.dart';
import 'package:task/features/profile/domain/user_data.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepo repo;
  ProfileCubit(this.repo)
      : super(ProfileState(
            pageState: InitpageState(),
            userProfileData: UserProfileData(
                name: "",
                phone: "",
                level: "",
                yearsOfExperience: "",
                location: "")));

  void getUerData() async {
    emit(state.copyWith(pageState: LoadingPageState()));
    var res = await repo.getUser();
    res.fold((failure) {
      emit(state.copyWith(
          pageState: FailurePageState(errorMessage: failure.message)));
      emit(state.copyWith(pageState: InitpageState()));
    }, (data) {
      emit(
          state.copyWith(pageState: SuccessPageState(), userProfileData: data));
      emit(state.copyWith(pageState: InitpageState()));
    });
  }
}
