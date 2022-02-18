import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_assets_request.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/asset_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/cities_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/condition_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/country_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/data_after_put_response.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/hard_nft_type_select.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/phone_code_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/put_hard_nft_response.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/bc_txn_hash_model.dart';

import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'step_1_service.g.dart';

@RestApi()
abstract class Step1Client {
  @factoryMethod
  factory Step1Client(Dio dio, {String baseUrl}) = _Step1Client;

  @GET(ApiConstants.GET_PHONE_CODE)
  Future<ListPhoneCodeResponse> getPhoneCode();

  @GET(ApiConstants.GET_COUNTRIES)
  Future<ListCountryResponse> getCountries();

  @GET('${ApiConstants.GET_CITIES}{id}${ApiConstants.PATH_GET_CITIES}')
  Future<CitiesResponse> getCities(@Path('id') String id);

  @GET(ApiConstants.GET_CONDITION)
  Future<ListConditionResponse> getConditions();

  @GET(ApiConstants.GET_HARD_NFT_TYPE)
  Future<ListHardNFTTypeResponse> getNFTTypes();

  @POST(ApiConstants.POST_ASSETS)
  Future<AssetResponse> createHardNFTAssets(
    @Body() CreateHardNftAssetsRequest request,
  );

  @PUT(
      '${ApiConstants.PUT_HARD_NFT_PREFIX}{id}${ApiConstants.PUT_HARD_NFT_SUFFIX}')
  Future<PutHardNftResponse> putHardNftBeforeConfirm(
    @Path('id') String id,
    @Body() BcTxnHashModel bcTxnHash,
  );

  @GET('${ApiConstants.GET_DETAIL_ASSETS_HARD_NFT}{asset_id}')
  Future<DataAfterPutResponse> getDetailAssetHardNFT(
    @Path('asset_id') String assetId,
  );
}
