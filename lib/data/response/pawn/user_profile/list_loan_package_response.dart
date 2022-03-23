import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_loan_package_response.g.dart';

@JsonSerializable()
class ListLoanPackage extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  Content? data;

  ListLoanPackage(this.code, this.data);

  factory ListLoanPackage.fromJson(Map<String, dynamic> json) =>
      _$ListLoanPackageFromJson(json);

  Map<String, dynamic> toJson() => _$ListLoanPackageToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class Content extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? content;

  Content(this.content);

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
  List<PawnshopPackage>? toDomain() => content?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'collateralTokens')
  List<AcceptableAssetsAsCollateralResponse>? acceptableAssetsAsCollateral;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'interest')
  num? interest;
  @JsonKey(name: 'interestMax')
  num? interestMax;
  @JsonKey(name: 'interestMin')
  num? interestMin;
  @JsonKey(name: 'loanToValue')
  num? loanToValue;
  @JsonKey(name: 'loanTokens')
  List<LoanTokensResponse>? loanToken;
  @JsonKey(name: 'name')
  String? name;

  DataResponse(
    this.acceptableAssetsAsCollateral,
    this.id,
    this.type,
    this.interest,
    this.interestMax,
    this.interestMin,
    this.loanToValue,
    this.loanToken,
    this.name,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  PawnshopPackage toDomain() => PawnshopPackage(
        acceptableAssetsAsCollateral:
            acceptableAssetsAsCollateral?.map((e) => e.toDomain()).toList(),
        id: id,
        interest: interest,
        loanToValue: loanToValue,
        type: type,
        interestMax: interestMax,
        interestMin: interestMin,
        loanToken: loanToken?.map((e) => e.toDomain()).toList(),
        name: name,
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

@JsonSerializable()
class LoanTokensResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  LoanTokensResponse(this.address, this.symbol);

  factory LoanTokensResponse.fromJson(Map<String, dynamic> json) =>
      _$LoanTokensResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoanTokensResponseToJson(this);

  LoanToken toDomain() => LoanToken(
        address: address,
        symbol: symbol,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
