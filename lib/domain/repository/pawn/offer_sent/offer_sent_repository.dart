import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_cryptp_collateral_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';

mixin OfferSentRepository {
  Future<Result<List<OfferSentCryptoModel>>> getListOfferSentCrypto({
    String? type,
    String? page,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  });

  Future<Result<UserInfoModel>> getUserId({
    String? email,
    String? type,
    String? walletAddress,
  });

  Future<Result<OfferSentDetailCryptoModel>> getOfferSentDetailCrypto({
    String? id,
  });

  Future<Result<OfferSentDetailCryptoCollateralModel>>
      getOfferSentDetailCryptoCollateral({
    String? id,
  });
}
