import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pawn_list_response.g.dart';

@JsonSerializable()
class PawnListResponse {
  @JsonKey(name: 'data')
  PawnDataResponse? data;

  PawnListResponse(
    this.data,
  );

  factory PawnListResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnListResponseToJson(this);
}

@JsonSerializable()
class PawnDataResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  PawnDataResponse(
    this.data,
  );

  factory PawnDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnDataResponseFromJson(json);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'content')
  List<ContentResponse>? content;

  DataResponse(
    this.content,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);
}

@JsonSerializable()
class ContentResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'availableLoanPackage')
  int? availableLoanPackage;
  @JsonKey(name: 'interest')
  double? interest;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'totalValue')
  double? totalValue;
  @JsonKey(name: 'isKYC')
  bool? isKYC;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'loanToken')
  List<TokenResponse>? loanToken;
  @JsonKey(name: 'collateralAccepted')
  List<TokenResponse>? collateralAccepted;

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  ContentResponse(
      this.id,
      this.name,
      this.availableLoanPackage,
      this.interest,
      this.reputation,
      this.avatar,
      this.totalValue,
      this.isKYC,
      this.userId,
      this.loanToken,
      this.collateralAccepted);

  PawnShopModel toDomain() => PawnShopModel(
        id: id,
        name: name,
        availableLoanPackage: availableLoanPackage,
        avatar: avatar,
        collateralAccepted:
            collateralAccepted?.map((e) => e.toDomain()).toList() ?? [],
        interest: interest,
        isKYC: isKYC,
        loanToken: loanToken?.map((e) => e.toDomain()).toList() ?? [],
        reputation: reputation,
        totalValue: totalValue,
        userId: userId,
      );
}

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;


  TokenResponse(this.id, this.symbol, this.address);

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  TokenModelPawn toDomain() => TokenModelPawn(
        id: id,
        symbol: symbol,
        address: address,
      );
}
