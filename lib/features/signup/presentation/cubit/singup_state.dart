part of 'singup_cubit.dart';

@immutable
 class SingupState extends Equatable {
  final PageState pageState;

  const SingupState({required this.pageState,});
   
  SingupState copyWith({
    PageState? pageState,
  }) {
    return SingupState(
      pageState: pageState ?? this.pageState,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [pageState];  
 }

