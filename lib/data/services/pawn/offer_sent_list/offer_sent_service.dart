import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_collateral_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/offer_sent_detail_crypto_response.dart';
import 'package:Dfy/data/response/pawn/offer_sent/user_infor_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

part 'offer_sent_service.g.dart';

@RestApi()
abstract class OfferSentService {
  @factoryMethod
  factory OfferSentService(Dio dio, {String baseUrl}) = _OfferSentService;

  @GET(ApiConstants.GET_LIST_OFFER_SENT_CRYPTO)
  Future<OfferSentCryptoTotalResponse> getListOfferSentCrypto(
    @Query('type') String? type,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('status') String? status,
    @Query('userId') String? userId,
    @Query('sort') String? sort,
    @Query('walletAddress') String? walletAddress,
  );

  @GET(ApiConstants.GET_USER_ID_PAWN)
  Future<UserInfoResponse> getUserId(
    @Query('email') String? email,
    @Query('type') String? type,
    @Query('walletAddress') String? walletAddress,
  );

  @GET('${ApiConstants.OFFER_DETAIL}{id}')
  Future<OfferSentDetailCryptoTotalResponse> getOfferSentDetailCrypto(
    @Path('id') String? id,
  );

  @GET('${ApiConstants.GET_DETAIL_COLLATERAL}{id}')
  Future<OfferSentDetailCryptoCollateralTotalResponse>
      getOfferSentDetailCryptoCollateral(
    @Path('id') String? id,
  );

  @PUT('${ApiConstants.OFFER_DETAIL}{id}/cancel')
  Future<String> putCryptoAfterCancel(
    @Path('id') String id,
  );
}
