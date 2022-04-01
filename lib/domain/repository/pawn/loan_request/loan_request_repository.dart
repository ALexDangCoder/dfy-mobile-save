import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';

mixin LoanRequestRepository {
  Future<Result<List<LoanRequestCryptoModel>>> getListCryptoLoanRequest({
    String? p2p,
    String? page,
    String? size,
    String? collateral,
    String? status,
    String? walletAddress,
  });
}
