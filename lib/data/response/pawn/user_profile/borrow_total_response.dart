import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'borrow_total_response.g.dart';

@JsonSerializable()
class BorrowResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  BorrowResponse(this.data);

  factory BorrowResponse.fromJson(Map<String, dynamic> json) =>
      _$BorrowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BorrowResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'totalAvailableCollaterals')
  int? totalAvailableCollateral;
  @JsonKey(name: 'totalContracts')
  int? totalContracts;
  @JsonKey(name: 'totalValue')
  double? totalValue;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'symbols')
  List<String>? symbol;


  DataResponse(this.totalAvailableCollateral, this.totalValue,
      this.reputation, this.symbol,this.totalContracts);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
  BorrowAvailableCollateral toCollateral() => BorrowAvailableCollateral(
    totalAvailableCollateral: totalAvailableCollateral,
    totalValue: totalValue,
    reputation: reputation,
    symbol: symbol,
  );
  BorrowAvailableCollateral toSignContract() => BorrowAvailableCollateral(
    totalContract: totalContracts,
    totalValue: totalValue,
    reputation: reputation,
    symbol: symbol,
  );
}
