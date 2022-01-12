import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_res.g.dart';

@JsonSerializable()
class ConfirmResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rd')
  String? rd;

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ConfirmModel toDomain() {
    return ConfirmModel(rd: rd ?? '', rc: rc ?? -1);
  }
}
