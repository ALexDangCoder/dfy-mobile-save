import 'package:Dfy/data/response/activity_collection/activity_collection.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'collection_detail_service.g.dart';

@RestApi()
abstract class CollectionDetailService {
  @factoryMethod
  factory CollectionDetailService(Dio dio, {String baseUrl}) =
      _CollectionDetailService;

  @GET('${ApiConstants.COLLECTION_DETAIL}{id}')
  Future<CollectionDetailRes> getCollection(
    @Path('id') String idCollection,
  );

  @GET(ApiConstants.COLLECTION_ACTIVITY_LIST)
  Future<ActivityCollectionResponse> getListActivityCollection(
    @Query('address') String collectionAddress,
    @Query('type') String type,
  );
}
