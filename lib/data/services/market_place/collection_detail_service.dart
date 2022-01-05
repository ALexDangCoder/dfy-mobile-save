import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'collection_detail_service.g.dart';

@RestApi()
abstract class CollectionDetailService {
  @factoryMethod
  factory CollectionDetailService(Dio dio, {String baseUrl}) = _CollectionDetailService;

  @GET(ApiConstants.COLLECTION_DETAIL)
  Future<CollectionDetailRes> getCollection(
      @Path('id') String idCollection,
      );
}
