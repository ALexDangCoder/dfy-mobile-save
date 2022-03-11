import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CollateralResultNFTState extends Equatable {}

class CollateralResultInitial extends CollateralResultNFTState {
  @override
  List<Object?> get props => [];
}

class CollateralResultLoading extends CollateralResultNFTState {
  @override
  List<Object?> get props => [];
}

class CollateralResultSuccess extends CollateralResultNFTState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<NftMarket>? listCollateral;
  final String? message;

  CollateralResultSuccess(
    this.completeType, {
    this.listCollateral,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listCollateral, message];
}
