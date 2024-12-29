part of 'profile_cubit.dart';
class ProfileState extends Equatable {
  const ProfileState({
    required this.pageState,
    required this.userProfileData,
  });

  final UserProfileData userProfileData;
  final PageState pageState;

  ProfileState copyWith({
    UserProfileData? userProfileData,
    PageState? pageState,
  }) {
    return ProfileState(
      userProfileData: userProfileData ?? this.userProfileData,
      pageState: pageState ?? this.pageState,
    );
  }

  @override
  List<Object> get props => [pageState, userProfileData];
}