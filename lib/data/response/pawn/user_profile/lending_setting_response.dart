import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lending_setting_response.g.dart';

@JsonSerializable()
class LendingSettingResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  LendingSettingResponse(this.data);

  factory LendingSettingResponse.fromJson(Map<String, dynamic> json) =>
      _$LendingSettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LendingSettingResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'interestMin')
  int? interestMin;
  @JsonKey(name: 'interestMax')
  int? interestMax;
  @JsonKey(name: 'lendingType')
  int? lendingType;
  @JsonKey(name: 'associatedWalletAddress')
  String? associatedWallerAddress;
  @JsonKey(name: 'collateralAcceptances')
  List<RepaymentTokensResponse>? collateralAcceptances;

  DataResponse(
      this.id,
      this.userId,
      this.interestMin,
      this.interestMax,
      this.lendingType,
      this.associatedWallerAddress,
      this.collateralAcceptances);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  LendingSetting toDomain() => LendingSetting(
        id: id,
        userId: userId,
        interestMax: interestMax,
        interestMin: interestMin,
        lendingType: lendingType,
        associatedWallerAddress: associatedWallerAddress,
        collateralAcceptances:
            collateralAcceptances?.map((e) => e.toDomain()).toList(),
      );
}

@JsonSerializable()
class RepaymentTokensResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  RepaymentTokensResponse(this.address, this.symbol);

  factory RepaymentTokensResponse.fromJson(Map<String, dynamic> json) =>
      _$RepaymentTokensResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentTokensResponseToJson(this);

  RepaymentToken toDomain() => RepaymentToken(
        address: address,
        symbol: symbol,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
