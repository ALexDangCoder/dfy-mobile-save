part of 'loan_package_cubit.dart';

@immutable
abstract class LoanPackageState extends Equatable {}

class LoanPackageInitial extends LoanPackageState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoanPackageSuccess extends LoanPackageState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final PawnshopPackage? pawnshopPackage;
  final String? message;

  LoanPackageSuccess(
    this.completeType, {
    this.pawnshopPackage,
    this.message,
  });

  // TODO: implement props
  @override
  List<Object?> get props => throw [
        id,
        completeType,
        pawnshopPackage,
        message,
      ];
}
