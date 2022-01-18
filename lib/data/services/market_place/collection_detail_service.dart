import 'package:Dfy/data/response/activity_collection/activity_collection.dart';
import 'package:Dfy/data/response/collection/collection_res.dart';
import 'package:Dfy/data/response/collection/list_collection_res_market.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_filter_response.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/data/response/nft_market/list_nft_collection_respone.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'collection_detail_service.g.dart';

@RestApi()
abstract class CollectionDetailService {
  @factoryMethod
  factory CollectionDetailService(Dio dio, {String baseUrl}) =
      _CollectionDetailService;

  @GET('${ApiConstants.COLLECTION_DETAIL}{id}')
  Future<CollectionDetailResponse> getCollection(
    @Path('id') String idCollection,
  );

  @GET(ApiConstants.COLLECTION_ACTIVITY_LIST)
  Future<ActivityCollectionResponse> getListActivityCollection(
    @Query('address') String collectionAddress,
    @Query('type') String type,
    @Query('page') int page,
    @Query('size') int size,
  );

  @GET(ApiConstants.GET_LIST_FILTER_COLLECTION_DETAIL)
  Future<CollectionDetailFilterResponse> getListFilterCollectionDetail(
    @Query('collection_address') String? collectionAddress,
  );

  @POST(ApiConstants.GET_LIST_NFT_COLLECTION)
  Future<ListNftCollectionResponse> getListNftCollection(
    @Field('collection_address') String? collectionAddress,
    @Field('page') int? page,
    @Field('size') int? size,
    @Field('name') String? nameNft,
    @Field('market_type') List<int>? listMarketType,
  );

  @GET(ApiConstants.GET_LIST_COLLECTION)
  Future<ListCollectionResponse> getListCollection(
    @Query('wallet_address') String? addressWallet,
    @Query('name') String? name,
    @Query('collection_type') int? collectionType,
    @Query('sort') int? sort,
    @Query('page') int? page,
    @Query('size') int? size,
  );

  @GET(ApiConstants.GET_LIST_COLLECTION_MARKET)
  Future<ListCollectionResponseMarket> getListCollectionMarket(
    @Query('address') String? address,
    @Query('name') String? name,
    @Query('sort') int? sort,
    @Query('page') int? page,
    @Query('size') int? size,
  );
}
