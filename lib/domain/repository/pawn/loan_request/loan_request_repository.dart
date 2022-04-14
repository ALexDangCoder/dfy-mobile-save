import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/detail_loan_request_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';

mixin LoanRequestRepository {
  Future<Result<List<LoanRequestCryptoModel>>> getListCryptoLoanRequest({
    String? p2p,
    String? page,
    String? size,
    String? collateral,
    String? status,
    String? walletAddress,
  });

  Future<Result<List<LoanRequestCryptoModel>>> getListNftLoanRequest({
    String? page,
    String? size,
    String? nftType,
    String? status,
    String? walletAddress,
  });

  Future<Result<List<ReputationBorrower>>> getBorrowerInfo(
      String walletAddress);

  Future<Result<DetailLoanRequestCryptoModel>> getDetailLoanRequest(String id);

  Future<Result<String>> postSendOfferCryptoToBe({
    required String id,
    String? collateralId,
    String? duration,
    String? durationType,
    String? interestRate,
    String? latestBlockchainTxn,
    String? liquidationThreshold,
    String? loanAmount,
    String? loanRequestId,
    String? loanToValue,
    String? message,
    String? repaymentToken,
    String? supplyCurrency,
    String? walletAddress,
  });

  Future<Result<String>> postRejectCryptoLoanRequest({
    required String loanRequestId,
  });
}
