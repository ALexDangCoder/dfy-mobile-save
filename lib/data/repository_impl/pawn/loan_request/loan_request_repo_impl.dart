import 'package:Dfy/data/response/home_pawn/list_reputation_borrower_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/detail_loan_request_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/loan_request_crypto_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/loan_request_list/loan_request_list_service.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/detail_loan_request_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
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
          () =>
          _client.getLoanRequestListCrypto(
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

  @override
  Future<Result<List<ReputationBorrower>>> getBorrowerInfo(
      String walletAddress) {
    return runCatchingAsync<List<ReputationBorrowerResponse>,
        List<ReputationBorrower>>(
          () =>
          _client.getBorrowerInfo(
            walletAddress,
          ),
          (response) => response.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  Future<Result<DetailLoanRequestCryptoModel>> getDetailLoanRequest(String id) {
    return runCatchingAsync<DetailLoanRequestTotalResponse,
        DetailLoanRequestCryptoModel>(
          () => _client.getDetailLoanRequest(id),
          (response) => response.data.toModel(),
    );
  }

  @override
  Future<Result<List<LoanRequestCryptoModel>>> getListNftLoanRequest(
      {String? page, String? size, String? nftType, String? status, String? walletAddress}) {
    return runCatchingAsync<LoanRequestCryptoTotalResponse,
        List<LoanRequestCryptoModel>>(
          () =>
          _client.getListNftLoanRequest(
            nftType,
            status,
            walletAddress,
            page,
            size,
          ),
          (response) =>
      response.data?.content?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
