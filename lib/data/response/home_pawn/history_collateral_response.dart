import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_collateral_response.g.dart';

@JsonSerializable()
class HistoryCollateralResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataResponse>? data;

  HistoryCollateralResponse(this.data);

  factory HistoryCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryCollateralResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'txnHash')
  String? txnHash;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'status')
  int? status;

  DataResponse(
    this.id,
    this.symbol,
    this.amount,
    this.txnHash,
    this.createdAt,
    this.status,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  HistoryCollateralModel toDomain() => HistoryCollateralModel(
        id: id,
        amount: amount,
        status: status,
        symbol: symbol,
        createdAt: createdAt,
        txnHash: txnHash,
      );
}
