import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';

class NftOnRequestLoanItemModel {
  List<ContentNftOnRequestLoanModel>? content;
  int? number;
  int? page;
  int? size;
  int? numberOfElements;
  bool? isFirst;
  bool? isLast;
  bool? hasNext;
  bool? hasPrevious;
  int? totalPages;
  int? totalElements;

  NftOnRequestLoanItemModel({
    this.content,
    this.number,
    this.page,
    this.size,
    this.numberOfElements,
    this.isFirst,
    this.isLast,
    this.hasNext,
    this.hasPrevious,
    this.totalPages,
    this.totalElements,
  });
}

class ContentNftOnRequestLoanModel {
  int? id;
  int? userId;
  String? collateralSymbol;
  String? collateralAddress;
  double? collateralAmount;
  String? loanSymbol;
  int? status;
  int? durationType;
  int? durationQty;
  int? bcCollateralId;
  int? numberOfferReceived;
  String? latestBlockchainTxn;
  double? estimatePrice;
  double? expectedLoanAmount;
  String? expectedCollateralSymbol;
  int? reputation;
  String? walletAddress;
  int? completedContracts;
  int? type;
  NftCollateralDetailDTO? nftCollateralDetailDTO;
  NftMarket? nft;

  ContentNftOnRequestLoanModel({
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.loanSymbol,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockchainTxn,
    this.estimatePrice,
    this.expectedLoanAmount,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completedContracts,
    this.type,
    this.nftCollateralDetailDTO,
    this.nft,
  });
}
