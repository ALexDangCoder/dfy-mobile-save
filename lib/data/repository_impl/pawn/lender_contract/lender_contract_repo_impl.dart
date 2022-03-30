import 'package:Dfy/data/response/pawn/lender_contract/lender_contract_nft_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/lender_contract/lender_contract_service.dart';
import 'package:Dfy/domain/model/pawn/lender_contract/lender_contract_nft_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/repository/pawn/lender_contract/lender_contract_repository.dart';

class LenderContractRepositoryImplement implements LenderContractRepository {
  final LenderContractService _client;

  LenderContractRepositoryImplement(this._client);

  @override
  Future<Result<List<LenderContractNftModel>>> getListOfferSentCrypto(
      {String? type,
      String? page,
      String? size,
      String? status,
      String? userId,
      String? sort,
      String? walletAddress}) {
    return runCatchingAsync<LenderContractNftReponse,
        List<LenderContractNftModel>>(
      () => _client.getListCryptoFtNft(
        type,
        page,
        size,
        status,
        userId,
        sort,
        walletAddress,
      ),
      (response) =>
          response.data?.content?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
