import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_lending_response.g.dart';

@JsonSerializable()
class PersonalLendingResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  PersonalLendingResponse(this.code, this.data);

  factory PersonalLendingResponse.fromJson(Map<String, dynamic> json) =>
      _$PersonalLendingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalLendingResponseToJson(this);

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
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'associatedAddress')
  String? associatedAddress;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'completedContracts')
  int? completedContracts;
  @JsonKey(name: 'coverImage')
  String? coverImage;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'isFeaturedPawnshop')
  bool? isFeaturedPawnshop;
  @JsonKey(name: 'isKYC')
  bool? isKYC;
  @JsonKey(name: 'isTrustedLender')
  bool? isTrustedLender;
  @JsonKey(name: 'maxInterestRate')
  num? maxInterestRate;
  @JsonKey(name: 'minInterestRate')
  num? minInterestRate;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'p2PLenderPackages')
  List<P2PLenderPackagesResponse>? p2PLenderPackages;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'rank')
  String? rank;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'totalLoanValue')
  double? totalLoanValue;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'updatedAt')
  int? updatedAt;
  @JsonKey(name: 'userId')
  int? userId;

  DataResponse(
    this.address,
    this.associatedAddress,
    this.avatar,
    this.completedContracts,
    this.coverImage,
    this.createdAt,
    this.description,
    this.email,
    this.id,
    this.isDeleted,
    this.isFeaturedPawnshop,
    this.isKYC,
    this.isTrustedLender,
    this.maxInterestRate,
    this.minInterestRate,
    this.name,
    this.p2PLenderPackages,
    this.phoneNumber,
    this.rank,
    this.reputation,
    this.totalLoanValue,
    this.type,
    this.updatedAt,
    this.userId,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  PersonalLending toDomain() => PersonalLending(
        address: address,
        associatedAddress: associatedAddress,
        avatar: avatar,
        completedContracts: completedContracts,
        coverImage: coverImage,
        createdAt: createdAt,
        description: description,
        email: email,
        id: id,
        isDeleted: isDeleted,
        isFeaturedPawnshop: isFeaturedPawnshop,
        isKYC: isKYC,
        isTrustedLender: isTrustedLender,
        maxInterestRate: maxInterestRate,
        minInterestRate: minInterestRate,
        name: name,
        p2PLenderPackages: p2PLenderPackages?.map((e) => e.toDomain()).toList(),
        rank: rank,
        phoneNumber: phoneNumber,
        reputation: reputation,
        totalLoanValue: totalLoanValue,
        type: type,
        updatedAt: updatedAt,
        userId: userId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class P2PLenderPackagesResponse extends Equatable {
  @JsonKey(name: 'acceptableAssetsAsCollateral')
  List<AcceptableAssetsAsCollateralResponse>? acceptableAssetsAsCollateral;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;

  P2PLenderPackagesResponse(
      this.acceptableAssetsAsCollateral, this.id, this.type);

  factory P2PLenderPackagesResponse.fromJson(Map<String, dynamic> json) =>
      _$P2PLenderPackagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$P2PLenderPackagesResponseToJson(this);

  P2PLenderPackages toDomain() => P2PLenderPackages(
        acceptableAssetsAsCollateral: acceptableAssetsAsCollateral
            ?.map(
              (e) => e.toDomain(),
            )
            .toList(),
        id: id,
        type: type,
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
