import 'package:Dfy/data/response/pawn/loan_request_list/loan_request_crypto_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/loan_request_list/loan_request_list_service.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/domain/repository/pawn/loan_request/loan_request_repository.dart';

class LoanRequestRepositoryImplement implements LoanRequestRepository {
  final LoanRequestListService _client;

  LoanRequestRepositoryImplement(this._client);

  @override
  Future<Result<List<LoanRequestCryptoModel>>> getListCryptoLoanRequest(
      {String? p2p,
      String? page,
      String? size,
      String? collateral,
      String? status,
      String? walletAddress}) {
    return runCatchingAsync<LoanRequestCryptoTotalResponse,
        List<LoanRequestCryptoModel>>(
      () => _client.getLoanRequestListCrypto(
        p2p,
        page,
        size,
        collateral,
        status,
        walletAddress,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
