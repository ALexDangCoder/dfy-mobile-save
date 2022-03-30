

import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/lender_contract/lender_contract_nft_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';

mixin LenderContractRepository {
  Future<Result<List<LenderContractNftModel>>> getListOfferSentCrypto({
    String? type,
    String? page,
    String? size,
    String? status,
    String? userId,
    String? sort,
    String? walletAddress,
  });


}
