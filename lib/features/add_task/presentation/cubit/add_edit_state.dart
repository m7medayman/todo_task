part of 'add_edit_cubit.dart';

class AddEditState extends Equatable {
  const AddEditState({this.id, required this.isEdit, required this.pageState});
  final bool isEdit;
  final PageState pageState;
  final String? id;

  @override
  List<Object> get props => [pageState, isEdit];
  AddEditState copyWith({bool? isEdit, PageState? pageState, String? id}) {
    return AddEditState(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        pageState: pageState ?? this.pageState);
  }
}
