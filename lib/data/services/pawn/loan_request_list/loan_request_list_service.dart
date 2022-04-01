import 'package:Dfy/data/response/pawn/lender_contract/lender_contract_nft_response.dart';
import 'package:Dfy/data/response/pawn/loan_request_list/loan_request_crypto_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';

part 'loan_request_list_service.g.dart';

@RestApi()
abstract class LoanRequestListService {
  @factoryMethod
  factory LoanRequestListService(Dio dio, {String baseUrl}) =
      _LoanRequestListService;

  @GET(ApiConstants.GET_LOAN_REQUEST_LIST)
  Future<LoanRequestCryptoTotalResponse> getLoanRequestListCrypto(
    @Query('p2p') String? p2p,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('collateral') String? collateral,
    @Query('status') String? status,
    @Query('walletAddress') String? walletAddress,

  );
}
