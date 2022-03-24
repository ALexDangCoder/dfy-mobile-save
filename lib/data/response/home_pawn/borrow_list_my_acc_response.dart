import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/nft_pawn_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'borrow_list_my_acc_response.g.dart';

@JsonSerializable()
class BorrowListMyAccResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  BorrowListMyAccResponse(this.code, this.data);

  factory BorrowListMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$BorrowListMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BorrowListMyAccResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? content;

  ContentResponse(this.content);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'supply_currency')
  String? supplyCurrency;
  @JsonKey(name: 'supply_currency_amount')
  double? supplyCurrencyAmount;
  @JsonKey(name: 'estimate_usd_supply_currency_amount')
  double? estimateUsdSupplyCurrencyAmount;
  @JsonKey(name: 'collateral')
  String? collateral;
  @JsonKey(name: 'collateral_amount')
  double? collateralAmount;
  @JsonKey(name: 'estimate_usd_collateral_amount')
  double? estimateUsdCollateralAmount;
  @JsonKey(name: 'interest_per_year')
  int? interestPerYear;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'duration_type')
  int? durationType;
  @JsonKey(name: 'lender_wallet_address')
  String? lenderWalletAddress;
  @JsonKey(name: 'lender_reputation')
  int? lenderReputation;
  @JsonKey(name: 'borrower_wallet_address')
  String? borrowerWalletAddress;
  @JsonKey(name: 'borrower_reputation')
  int? borrowerReputation;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'is_claimed')
  bool? isClaimed;
  @JsonKey(name: 'bc_contract_id')
  int? bcContractId;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'nft')
  NftResponse? nft;

  DataResponse(
    this.id,
    this.supplyCurrency,
    this.supplyCurrencyAmount,
    this.estimateUsdSupplyCurrencyAmount,
    this.collateral,
    this.collateralAmount,
    this.estimateUsdCollateralAmount,
    this.interestPerYear,
    this.duration,
    this.durationType,
    this.lenderWalletAddress,
    this.lenderReputation,
    this.borrowerWalletAddress,
    this.borrowerReputation,
    this.status,
    this.isClaimed,
    this.bcContractId,
    this.type,
    this.nft,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CryptoPawnModel toDomain() => CryptoPawnModel(
        id,
        supplyCurrency,
        supplyCurrencyAmount,
        estimateUsdSupplyCurrencyAmount,
        collateral,
        collateralAmount,
        estimateUsdCollateralAmount,
        interestPerYear,
        duration,
        durationType,
        lenderWalletAddress,
        lenderReputation,
        borrowerWalletAddress,
        borrowerReputation,
        status,
        isClaimed,
        bcContractId,
        type,
        nft?.toDomain(),
      );
}

@JsonSerializable()
class NftResponse extends Equatable {
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'nftType')
  int? nftType;
  @JsonKey(name: 'nftAddress')
  String? nftAddress;
  @JsonKey(name: 'nftName')
  String? nftName;
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'nftAvatarCid')
  String? nftAvatarCid;
  @JsonKey(name: 'nftMediaCid')
  String? nftMediaCid;
  @JsonKey(name: 'nftAssetTypeId')
  int? nftAssetTypeId;
  @JsonKey(name: 'nftAssetLocation')
  String? nftAssetLocation;
  @JsonKey(name: 'nftEvaluatedPrice')
  double? nftEvaluatedPrice;
  @JsonKey(name: 'nftEvaluatedSymbol')
  String? nftEvaluatedSymbol;
  @JsonKey(name: 'bcNftId')
  int? bcNftId;
  @JsonKey(name: 'collectionAddress')
  String? collectionAddress;
  @JsonKey(name: 'collectionName')
  String? collectionName;
  @JsonKey(name: 'isWhitelist')
  bool? isWhitelist;
  @JsonKey(name: 'assetTypeId')
  int? assetTypeId;
  @JsonKey(name: 'nftStatus')
  int? nftStatus;
  @JsonKey(name: 'nftAssetTypeIdRef')
  int? nftAssetTypeIdRef;
  @JsonKey(name: 'fileType')
  String? fileType;
  @JsonKey(name: 'numberOfCopies')
  String? numberOfCopies;
  @JsonKey(name: 'totalOfCopies')
  String? totalOfCopies;

  NftResponse(
    this.nftId,
    this.nftType,
    this.nftAddress,
    this.nftName,
    this.expectedLoanAmount,
    this.nftAvatarCid,
    this.nftMediaCid,
    this.nftAssetTypeId,
    this.nftAssetLocation,
    this.nftEvaluatedPrice,
    this.nftEvaluatedSymbol,
    this.bcNftId,
    this.collectionAddress,
    this.collectionName,
    this.isWhitelist,
    this.assetTypeId,
    this.nftStatus,
    this.nftAssetTypeIdRef,
    this.fileType,
    this.numberOfCopies,
    this.totalOfCopies,
  );

  factory NftResponse.fromJson(Map<String, dynamic> json) =>
      _$NftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  NFTPawnModel toDomain() => NFTPawnModel(
        nftId,
        nftType,
        nftAddress,
        nftName,
        expectedLoanAmount,
        nftAvatarCid,
        nftMediaCid,
        nftAssetTypeId,
        nftAssetLocation,
        nftEvaluatedPrice,
        nftEvaluatedSymbol,
        bcNftId,
        collectionAddress,
        collectionName,
        isWhitelist,
        assetTypeId,
        nftStatus,
        nftAssetTypeIdRef,
        fileType,
        numberOfCopies,
        totalOfCopies,
      );
}
