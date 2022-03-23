import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collateral_widraw_response.g.dart';

@JsonSerializable()
class CollateralWithDrawResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  CollateralWithDrawResponse(this.error);

  factory CollateralWithDrawResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralWithDrawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralWithDrawResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
