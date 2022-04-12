import 'package:json_annotation/json_annotation.dart';

part 'create_new_loan_package_request.g.dart';

@JsonSerializable()
class CreateNewLoanPackageRequest {
  String? associatedWalletAddress;
  CollateralAcceptancesRequest? collateralAcceptances;
  String? description;
  String? durationQtyMax;
  String? durationQtyMin;
  String? durationQtyType;
  String? allowedLoanMin;
  String? allowedLoanMax;
  String? interest;
  String? liquidationThreshold;
  String? loanToValue;
  LoanTokensRequest? loanTokens;
  String? recurringInterest;
  String? txid;
  RepaymentTokensRequest? repaymentTokens;
  String? pawnShopId;
  String? type;

  CreateNewLoanPackageRequest({
    this.associatedWalletAddress,
    this.collateralAcceptances,
    this.description,
    this.durationQtyMax,
    this.durationQtyMin,
    this.durationQtyType,
    this.allowedLoanMin,
    this.allowedLoanMax,
    this.interest,
    this.liquidationThreshold,
    this.loanToValue,
    this.loanTokens,
    this.recurringInterest,
    this.txid,
    this.repaymentTokens,
    this.pawnShopId,
    this.type,
  });


  @override
  String toString() {
    return 'CreateNewLoanPackageRequest{associatedWalletAddress: $associatedWalletAddress, collateralAcceptances: $collateralAcceptances, description: $description, durationQtyMax: $durationQtyMax, durationQtyMin: $durationQtyMin, durationQtyType: $durationQtyType, allowedLoanMin: $allowedLoanMin, allowedLoanMax: $allowedLoanMax, interest: $interest, liquidationThreshold: $liquidationThreshold, loanToValue: $loanToValue, loanTokens: $loanTokens, recurringInterest: $recurringInterest, txid: $txid, repaymentTokens: $repaymentTokens, pawnShopId: $pawnShopId, type: $type}';
  }

  factory CreateNewLoanPackageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNewLoanPackageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewLoanPackageRequestToJson(this);
}

@JsonSerializable()
class CollateralAcceptancesRequest {
  List<String>? collaterals;

  CollateralAcceptancesRequest({this.collaterals});

  factory CollateralAcceptancesRequest.fromJson(Map<String, dynamic> json) =>
      _$CollateralAcceptancesRequestFromJson(json);


  @override
  String toString() {
    return 'CollateralAcceptancesRequest{collaterals: $collaterals}';
  }

  Map<String, dynamic> toJson() => _$CollateralAcceptancesRequestToJson(this);
}

@JsonSerializable()
class RepaymentTokensRequest {
  List<String>? repaymentTokens;

  RepaymentTokensRequest({this.repaymentTokens});

  factory RepaymentTokensRequest.fromJson(Map<String, dynamic> json) =>
      _$RepaymentTokensRequestFromJson(json);


  @override
  String toString() {
    return 'RepaymentTokensRequest{repaymentTokens: $repaymentTokens}';
  }

  Map<String, dynamic> toJson() => _$RepaymentTokensRequestToJson(this);
}

@JsonSerializable()
class LoanTokensRequest {
  List<String>? loanTokens;

  LoanTokensRequest({this.loanTokens});


  @override
  String toString() {
    return 'LoanTokensRequest{loanTokens: $loanTokens}';
  }

  factory LoanTokensRequest.fromJson(Map<String, dynamic> json) =>
      _$LoanTokensRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoanTokensRequestToJson(this);
}
