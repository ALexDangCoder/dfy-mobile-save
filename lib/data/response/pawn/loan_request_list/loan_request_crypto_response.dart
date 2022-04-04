import 'package:Dfy/data/response/home_pawn/borrow_list_my_acc_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/detail_loan_request_response.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loan_request_crypto_response.g.dart';

@JsonSerializable()
class LoanRequestCryptoTotalResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  ContentResponse? data;

  @JsonKey(name: 'trace_id')
  String? traceId;

  LoanRequestCryptoTotalResponse(
      this.error, this.code, this.data, this.traceId);

  factory LoanRequestCryptoTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$LoanRequestCryptoTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoanRequestCryptoTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<LoanRequestCryptoItemResponse>? content;

  ContentResponse(this.content);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LoanRequestCryptoItemResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'collateralId')
  int? collateralId;
  @JsonKey(name: 'collateralOwner')
  CollateralOwnerResponse? collateralOwner;
  @JsonKey(name: 'p2pLenderPackage')
  P2PLenderPackageResponse? p2pLenderPackage;

  ///this is for nft
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'expectedLoanSymbol')
  String? expectedLoanSymbol;
  @JsonKey(name: 'nft')
  NftResponse? nft;

  LoanRequestCryptoItemResponse(
    this.id,
    this.collateralSymbol,
    this.collateralAmount,
    this.loanSymbol,
    this.description,
    this.message,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.collateralId,
    this.p2pLenderPackage,
    this.collateralOwner,
    this.expectedLoanAmount,
    this.nft,
    this.expectedLoanSymbol,
  );

  LoanRequestCryptoModel toModel() => LoanRequestCryptoModel(
        status: status,
        description: description,
        id: id,
        collateralSymbol: collateralSymbol,
        collateralAmount: collateralAmount,
        loanSymbol: loanSymbol,
        durationType: durationType,
        durationQty: durationQty,
        bcCollateralId: bcCollateralId,
        collateralId: collateralId,
        message: message,
        p2pLenderPackageModel: p2pLenderPackage?.toModel(),
        collateralOwner: collateralOwner?.toModel(),
        nftModel: nft?.toDomain(),
        expectedLoanAmount: expectedLoanAmount,
        expectedLoanSymbol: expectedLoanSymbol,
      );

  factory LoanRequestCryptoItemResponse.fromJson(Map<String, dynamic> json) =>
      _$LoanRequestCryptoItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoanRequestCryptoItemResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class P2PLenderPackageResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;

  P2PLenderPackageResponse(this.id, this.name, this.type);

  P2PLenderPackageModel toModel() =>
      P2PLenderPackageModel(name: name, id: id, type: type);

  factory P2PLenderPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$P2PLenderPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$P2PLenderPackageResponseToJson(this);

  @override
  List<Object?> get props => [];
}
