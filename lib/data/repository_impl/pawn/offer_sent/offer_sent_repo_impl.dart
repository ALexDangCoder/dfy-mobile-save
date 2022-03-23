import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_collateral_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/user_infor_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/offer_sent_list/offer_sent_service.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_cryptp_collateral_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';

class OfferSentRepositoryImplement implements OfferSentRepository {
  final OfferSentService _client;

  OfferSentRepositoryImplement(this._client);

  @override
  Future<Result<List<OfferSentCryptoModel>>> getListOfferSentCrypto({
    String? type,
    String? page,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  }) {
    return runCatchingAsync<OfferSentCryptoTotalResponse,
        List<OfferSentCryptoModel>>(
      () => _client.getListOfferSentCrypto(
        type,
        page,
        size,
        status,
        userId,
        sort,
        walletAddress,
      ),
      (response) =>
          response.data.content?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<UserInfoModel>> getUserId(
      {String? email, String? type, String? walletAddress}) {
    return runCatchingAsync<UserInfoResponse, UserInfoModel>(
      () => _client.getUserId(
        email,
        type,
        walletAddress,
      ),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<OfferSentDetailCryptoModel>> getOfferSentDetailCrypto(
      {String? id}) {
    return runCatchingAsync<OfferSentDetailCryptoTotalResponse,
        OfferSentDetailCryptoModel>(
      () => _client.getOfferSentDetailCrypto(id),
      (response) => response.data.toModel(),
    );
  }

  @override
  Future<Result<OfferSentDetailCryptoCollateralModel>>
      getOfferSentDetailCryptoCollateral({String? id}) {
    return runCatchingAsync<OfferSentDetailCryptoCollateralTotalResponse,
        OfferSentDetailCryptoCollateralModel>(
      () => _client.getOfferSentDetailCryptoCollateral(id),
      (response) => response.data.toOfferDetailCryptoCollateral(),
    );
  }
}
