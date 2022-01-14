import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/response/market_place/confirm_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'confirm_service.g.dart';

@RestApi()
abstract class ConfirmClient {
  @factoryMethod
  factory ConfirmClient(Dio dio, {String baseUrl}) = _ConfirmClient;

  //Confirm cancel  sale:
  @POST(ApiConstants.CANCEL_SALE)
  Future<ConfirmResponse> cancelSale(
    @Field('market_id') String marketId,
    @Field('txn_hash') String txnHash,
  );

  //CreateSoftCollection
  @POST(ApiConstants.CREATE_SOFT_COLLECTION)
  Future<ConfirmResponse> createSoftCollection(
    @Body() CreateSoftCollectionRequest data,
  );

  //CreateHardCollection
  @POST(ApiConstants.CREATE_HARD_COLLECTION)
  Future<ConfirmResponse> createHardCollection(
      @Body() CreateHardCollectionRequest data,
      );
}
