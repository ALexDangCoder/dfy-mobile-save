

import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';

mixin LenderContractRepository {
  Future<Result<List<CryptoPawnModel>>> getListOfferSentCrypto({
    String? type,
    String? page,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  });


}
