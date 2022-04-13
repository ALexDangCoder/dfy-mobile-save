import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'find_by_user_id_response.g.dart';

@JsonSerializable()
class FindByUserIdTotalResponse extends Equatable {
  @JsonKey(name: 'data')
  PawnShopResponse data;


  FindByUserIdTotalResponse(this.data);

  factory FindByUserIdTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$FindByUserIdTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FindByUserIdTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}