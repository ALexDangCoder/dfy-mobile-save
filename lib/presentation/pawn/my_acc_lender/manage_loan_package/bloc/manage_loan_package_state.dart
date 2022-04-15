part of 'manage_loan_package_cubit.dart';

abstract class ManageLoanPackageState extends Equatable {
  const ManageLoanPackageState();
}

class ManageLoanPackageInitial extends ManageLoanPackageState {
  @override
  List<Object> get props => [];
}


class LoadMoreManageLoanPackage extends ManageLoanPackageState {
  @override
  List<Object> get props => [];
}

class ManageLoadApiListPawnShop extends ManageLoanPackageState {
  final List<PawnshopPackage>? list;
  final CompleteType completeType;

  ManageLoadApiListPawnShop(
    this.completeType, {
    this.list,
  });

  @override
  List<Object?> get props => [
        list,
        completeType,
      ];
}

class NotPawnShopFound extends ManageLoanPackageState {
  @override
  List<Object> get props => [];
}
