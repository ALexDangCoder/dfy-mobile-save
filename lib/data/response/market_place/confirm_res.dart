import 'package:Dfy/domain/model/market_place/confirm_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_res.g.dart';

@JsonSerializable()
class ConfirmResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'data')
  DateResponse? data;

  ConfirmResponse(
    this.rc,
    this.rd,
    this.data,
  );

  factory ConfirmResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmResponseToJson(this);

  ConfirmModel toDomain() => ConfirmModel(
        rc: rc ?? -1,
        rd: rd ?? '', id: data?.collateralId ??0,
      );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class DateResponse extends Equatable {
  @JsonKey(name: 'collateralId')
  int? collateralId;

  DateResponse(this.collateralId);

  factory DateResponse.fromJson(Map<String, dynamic> json) =>
      _$DateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DateResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
