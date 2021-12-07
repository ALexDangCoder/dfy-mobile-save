import 'package:Dfy/domain/model/token_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isWhitelistCollateral')
  bool? isWhitelistCollateral;
  @JsonKey(name: 'isWhitelistSupply')
  bool? isWhitelistSupply;
  @JsonKey(name: 'usdExchange')
  double? usdExchange;
  @JsonKey(name: 'isAcceptedAsCollateral')
  bool? isAcceptedAsCollateral;
  @JsonKey(name: 'isAcceptedAsLoan')
  bool? isAcceptedAsLoan;
  @JsonKey(name: 'isAcceptedRepayment')
  bool? isAcceptedRepayment;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;

  TokenResponse(
    this.id,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.isAcceptedAsCollateral,
    this.isAcceptedAsLoan,
    this.isAcceptedRepayment,
    this.address,
    this.iconUrl,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  TokenModel toDomain() => TokenModel(
        id: id,
        isWhitelistCollateral: isWhitelistCollateral,
        iconUrl: iconUrl,
        isWhitelistSupply: isWhitelistSupply,
        usdExchange: usdExchange,
        isAcceptedAsCollateral: isAcceptedAsCollateral,
        isAcceptedAsLoan: isAcceptedAsLoan,
        isAcceptedRepayment: isAcceptedRepayment,
        address: address,
      );
}
