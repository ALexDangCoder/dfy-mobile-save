
import 'package:Dfy/utils/constants/app_constants.dart';

class PutOnMarketModel {
  int? nftTokenId;
  String? nftId;
  String? tokenAddress;
  int? numberOfCopies;
  int? nftType;
  String? price;
  String? collectionAddress;

  // auction
  String? buyOutPrice;
  String? priceStep;
  String? startTime;
  String? endTime;

  //pawn
  int? durationType;
  String? duration;
  bool? collectionIsWhitelist;
  String? collectionName;
  String? nftMediaCid;
  String? nftMediaType;
  String? loanSymbol;
  String? nftName;
  int? nftStandard;
  int? totalOfCopies;

  PutOnMarketModel({
    this.tokenAddress,
    this.collectionAddress,
    this.nftId,
    this.nftTokenId,
    this.nftType,
    this.numberOfCopies,
    this.price,
    this.buyOutPrice,
    this.priceStep,
    this.collectionIsWhitelist,
    this.collectionName,
    this.totalOfCopies,
    this.nftMediaType,
    this.nftMediaCid,
    this.nftName,
    this.nftStandard,
  });

  factory PutOnMarketModel.putOnSale({
    required int nftTokenId,
    required String  nftId,
    required int nftType,
    required String collectionAddress,
    required bool collectionIsWhitelist,
    required String collectionName,
    required String nftMediaCid,
    required String nftMediaType,
    required String nftName,
    required int nftStandard,
    required int totalOfCopies,
  }) {
    return PutOnMarketModel(
      nftId:  nftId,
      nftTokenId: nftTokenId,
      nftType:  nftType,
      collectionAddress:  collectionAddress,
      collectionIsWhitelist: collectionIsWhitelist,
      collectionName: collectionName,
      nftMediaCid: nftMediaCid,
      nftMediaType:  nftMediaType,
      nftName: nftName,
      nftStandard:  nftStandard,
      totalOfCopies:  totalOfCopies,
    );
  }
}
