import 'package:Dfy/domain/model/pawn/result_create_new_collateral_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_new_collateral_response.g.dart';

@JsonSerializable()
class CreateNewCollateralResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  CreateNewCollateralResponse(this.data);

  factory CreateNewCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewCollateralResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'txnId')
  String? txnId;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'expected_loan_duration_time')
  int? expectedLoanDurationTime;
  @JsonKey(name: 'expected_loan_duration_type')
  int? expectedLoanDurationType;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  int? status;

  DataResponse(
    this.userId,
    this.txnId,
    this.id,
    this.walletAddress,
    this.amount,
    this.expectedLoanDurationTime,
    this.expectedLoanDurationType,
    this.description,
    this.status,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ResultCreateNewModel toDomain() => ResultCreateNewModel(
        amount: amount,
        status: status,
        walletAddress: walletAddress,
        txnId: txnId,
        description: description,
        userId: userId,
        id: id,
        expectedLoanDurationTime: expectedLoanDurationTime,
        expectedLoanDurationType: expectedLoanDurationType,
      );
}
