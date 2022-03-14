import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_lending_hard_response.g.dart';

@JsonSerializable()
class PersonalLendingHardResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  PersonalLendingHardResponse(this.code, this.data);

  factory PersonalLendingHardResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonalLendingHardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalLendingHardResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  List<PersonalLending>? toDomain() => data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'interestMin')
  int? interestMin;
  @JsonKey(name: 'interestMax')
  int? interestMax;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'signedContract')
  int? signedContract;
  @JsonKey(name: 'collateralAccept')
  int? collateralAccept;
  @JsonKey(name: 'totalValue')
  double? totalValue;
  @JsonKey(name: 'isKYC')
  bool? isKYC;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'associatedWalletAddress')
  String? associatedWalletAddress;
  @JsonKey(name: 'isTrustedLender')
  bool? isTrustedLender;
  @JsonKey(name: 'collateralAccepted')
  List<AcceptableAssetsAsCollateralResponse>? collateralAccepted;

  DataResponse(
    this.id,
    this.name,
    this.interestMin,
    this.interestMax,
    this.reputation,
    this.signedContract,
    this.collateralAccept,
    this.totalValue,
    this.isKYC,
    this.userId,
    this.associatedWalletAddress,
    this.isTrustedLender,
    this.collateralAccepted,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  PersonalLending toDomain() => PersonalLending(
        id: id,
        name: name,
        minInterestRate: interestMin,
        maxInterestRate: interestMax,
        reputation: reputation,
        completedContracts: signedContract,
        totalLoanValue: totalValue,
        isKYC: isKYC,
        userId: userId,
        address: associatedWalletAddress,
        isTrustedLender: isTrustedLender,
        type: collateralAccept,
        collateralAccepted:
            collateralAccepted?.map((e) => e.toDomain()).toList() ?? [],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AcceptableAssetsAsCollateralResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  AcceptableAssetsAsCollateralResponse(this.address, this.symbol);

  factory AcceptableAssetsAsCollateralResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AcceptableAssetsAsCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AcceptableAssetsAsCollateralResponseToJson(this);

  AcceptableAssetsAsCollateral toDomain() => AcceptableAssetsAsCollateral(
        address: address,
        symbol: symbol,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
