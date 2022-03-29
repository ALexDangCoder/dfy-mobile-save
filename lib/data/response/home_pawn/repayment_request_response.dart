import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repayment_request_response.g.dart';

@JsonSerializable()
class RepaymentRequestResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  RepaymentRequestResponse(this.data);

  factory RepaymentRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$RepaymentRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentRequestResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'content')
  List<ContentResponse>? content;

  DataResponse(this.content);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class ContentResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'startDate')
  int? startDate;
  @JsonKey(name: 'dueDate')
  int? dueDate;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'isLocked')
  bool? isLocked;
  @JsonKey(name: 'borrowerWalletAddress')
  String? borrowerWalletAddress;
  @JsonKey(name: 'lenderWalletAddress')
  String? lenderWalletAddress;
  @JsonKey(name: 'systemFee')
  double? systemFee;
  @JsonKey(name: 'prepaidFee')
  double? prepaidFee;
  @JsonKey(name: 'penalty')
  RepaymentTokenResponse? penalty;
  @JsonKey(name: 'interest')
  RepaymentTokenResponse? interest;
  @JsonKey(name: 'loan')
  RepaymentTokenResponse? loan;
  @JsonKey(name: 'smartContractType')
  int? smartContractType;
  @JsonKey(name: 'txnHash')
  String? txnHash;
  @JsonKey(name: 'paymentDate')
  int? paymentDate;
  @JsonKey(name: 'txnId')
  int? txnId;

  ContentResponse(
    this.id,
    this.startDate,
    this.dueDate,
    this.status,
    this.isLocked,
    this.borrowerWalletAddress,
    this.lenderWalletAddress,
    this.systemFee,
    this.prepaidFee,
    this.penalty,
    this.interest,
    this.loan,
    this.smartContractType,
  );

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  RepaymentRequestModel toDomain() => RepaymentRequestModel(
        id,
        startDate,
        dueDate,
        status,
        isLocked,
        borrowerWalletAddress,
        lenderWalletAddress,
        systemFee,
        prepaidFee,
        penalty?.toDomain(),
        interest?.toDomain(),
        loan?.toDomain(),
        smartContractType,
        txnHash,
        paymentDate,
        txnId,
      );
}

@JsonSerializable()
class RepaymentTokenResponse {
  @JsonKey(name: 'amountPaid')
  double? amountPaid;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;

  RepaymentTokenResponse(
    this.amountPaid,
    this.amount,
    this.symbol,
    this.address,
  );

  factory RepaymentTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RepaymentTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentTokenResponseToJson(this);

  RepaymentTokenModel toDomain() => RepaymentTokenModel(
        amountPaid,
        amount,
        symbol,
        address,
      );
}
