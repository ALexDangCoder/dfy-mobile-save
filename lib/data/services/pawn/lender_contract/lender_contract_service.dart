import 'package:Dfy/data/response/pawn/lender_contract/lender_contract_nft_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_collateral_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/user_infor_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

part 'lender_contract_service.g.dart';

@RestApi()
abstract class LenderContractService {
  @factoryMethod
  factory LenderContractService(Dio dio, {String baseUrl}) =
      _LenderContractService;

  @GET(ApiConstants.GET_LIST_LOAN_CONTRACT_USER)
  Future<LenderContractNftReponse> getListCryptoFtNft(
    @Query('type') String? type,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('status') String? status,
    @Query('userId') String? userId,
    @Query('sort') String? sort,
    @Query('walletAddress') String? walletAddress,
  );
}
