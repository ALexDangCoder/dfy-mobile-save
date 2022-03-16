import 'package:Dfy/domain/model/home_pawn/send_offer_lend_crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_offer_lend_crypto_response.g.dart';

@JsonSerializable()
class SendOfferLendCryptoResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  SendOfferLendCryptoResponse(this.data);

  factory SendOfferLendCryptoResponse.fromJson(Map<String, dynamic> json) =>
      _$SendOfferLendCryptoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendOfferLendCryptoResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'loanAmount')
  double? loanAmount;
  @JsonKey(name: 'repaymentCycleType')
  int? repaymentCycleType;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestRate')
  double? interestRate;
  @JsonKey(name: 'liquidationThreshold')
  double? liquidationThreshold;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'bcOfferId')
  String? bcOfferId;
  @JsonKey(name: 'loanToValue')
  double? loanToValue;
  @JsonKey(name: 'smartContractType')
  double? smartContractType;
  @JsonKey(name: 'smartContractAddress')
  String? smartContractAddress;
  @JsonKey(name: 'txnId')
  String? txnId;
  @JsonKey(name: 'txnIdAccept')
  String? txnIdAccept;

  DataResponse(
    this.id,
    this.userId,
    this.walletAddress,
    this.loanAmount,
    this.repaymentCycleType,
    this.status,
    this.latestBlockchainTxn,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.liquidationThreshold,
    this.description,
    this.bcOfferId,
    this.loanToValue,
    this.smartContractType,
    this.smartContractAddress,
    this.txnId,
    this.txnIdAccept,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  SendOfferLendCryptoModel toDomain() => SendOfferLendCryptoModel(
        id: id,
        userId: userId,
        walletAddress: walletAddress,
        status: status,
        description: description,
        durationQty: durationQty,
        durationType: durationType,
        latestBlockchainTxn: latestBlockchainTxn,
        loanAmount: loanAmount,
        bcOfferId: bcOfferId,
        interestRate: interestRate,
        liquidationThreshold: liquidationThreshold,
        loanToValue: loanToValue,
        repaymentCycleType: repaymentCycleType,
        smartContractAddress: smartContractAddress,
        smartContractType: smartContractType,
        txnId: txnId,
        txnIdAccept: txnIdAccept,
      );
}
