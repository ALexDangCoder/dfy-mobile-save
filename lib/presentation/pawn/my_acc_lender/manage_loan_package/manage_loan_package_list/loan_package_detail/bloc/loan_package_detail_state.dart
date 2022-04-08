part of 'loan_package_detail_cubit.dart';

abstract class LoanPackageDetailState extends Equatable {
  const LoanPackageDetailState();
}

class LoanPackageDetailInitial extends LoanPackageDetailState {
  @override
  List<Object> get props => [];
}

class LoanPackageDetailLoadApi extends LoanPackageDetailState {
  final CompleteType completeType;
  final PawnshopPackage? pawnShopPackage;
  final List<CollateralResultModel>? listCollateral;


  LoanPackageDetailLoadApi(
      this.completeType, {this.pawnShopPackage, this.listCollateral});

  @override
  List<Object> get props => [];
}
