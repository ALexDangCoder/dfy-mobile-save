import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/domain/model/home_pawn/top_rate_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_rate_lenders_res.g.dart';

@JsonSerializable()
class TopRateLendersResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'trace-id')
  String? traceId;
  @JsonKey(name: 'data')
  List<TopRateLendersItemResponse>? data;

  TopRateLendersResponse(this.error, this.code, this.traceId, this.data);

  factory TopRateLendersResponse.fromJson(Map<String, dynamic> json) =>
      _$TopRateLendersResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TopRateLendersItemResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'positionItem')
  int? positionItem;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'pawnShop')
  PawnShopResponse? pawnShop;


  TopRateLendersItemResponse(this.id, this.positionItem, this.createdAt,
      this.updatedAt, this.isDeleted, this.pawnShop);

  factory TopRateLendersItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopRateLendersItemResponseFromJson(json);

  TopRateLenderModel toModel() => TopRateLenderModel(
        updatedAt: updatedAt,
        positionItem: positionItem,
        pawnShop: pawnShop?.toModel(),
        id: id,
        createdAt: createdAt,
        isDeleted: isDeleted,
      );

  @override
  List<Object?> get props => [];
}
