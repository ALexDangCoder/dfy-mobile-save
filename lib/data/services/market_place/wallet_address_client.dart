import 'package:Dfy/data/response/wallet_address/wallet_address_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'wallet_address_client.g.dart';

@RestApi()
abstract class WalletAddressClient {
  factory WalletAddressClient(Dio dio, {String baseUrl}) = _WalletAddressClient;

  @GET(ApiConstants.GET_LIST_WALLET)
  Future<ListWalletAddressResponse> getListWalletAddress();
}
