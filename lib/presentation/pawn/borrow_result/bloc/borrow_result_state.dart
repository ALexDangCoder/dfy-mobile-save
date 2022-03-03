part of 'borrow_result_cubit.dart';

@immutable
abstract class BorrowResultState extends Equatable {}

class BorrowResultInitial extends BorrowResultState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BorrowResultLoading extends BorrowResultState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BorrowPersonSuccess extends BorrowResultState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PersonalLending>? personalLending;
  final String? message;

  BorrowPersonSuccess(this.completeType, {this.personalLending, this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [id, completeType, personalLending, message];
}

class BorrowPawnshopSuccess extends BorrowResultState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PawnshopPackage>? pawnshopPackage;
  final String? message;

  BorrowPawnshopSuccess(
    this.completeType, {
    this.pawnshopPackage,
    this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, completeType, pawnshopPackage, message];
}
