part of 'home_pawn_cubit.dart';

abstract class HomePawnState extends Equatable {
  const HomePawnState();
}

class HomePawnInitial extends HomePawnState {
  @override
  List<Object> get props => [];
}

class HomePawnLoading extends HomePawnState {
  @override
  List<Object> get props => [];
}

class HomePawnLoadSuccess extends HomePawnState {
  final List<OfficialPawnItemModel>? listOfficialPawnItemModel;
  final List<TopRateLenderModel>? topRatedLenders;
  final List<TopSalePawnShopItemModel>? topSalePawnShopPackage;
  final List<NftsCollateralPawnModel>? nftsCollateralPawn;

   HomePawnLoadSuccess({
    this.listOfficialPawnItemModel,
    this.topRatedLenders,
    this.topSalePawnShopPackage,
    this.nftsCollateralPawn,
  });

  @override
  List<Object?> get props => [
        listOfficialPawnItemModel,
        topRatedLenders,
        topSalePawnShopPackage,
        nftsCollateralPawn,
      ];
}
