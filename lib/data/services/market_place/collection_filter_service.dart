import 'package:Dfy/data/response/collection_filter/list_response_call_api.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'collection_filter_service.g.dart';

@RestApi()
abstract class CollectionFilterClient {
  factory CollectionFilterClient(Dio dio, {String baseUrl}) = _CollectionFilterClient;

  @GET(ApiConstants.GET_LIST_COLLECTION_FILTER)
  Future<ListResponseFromApi> getListCollection();

}
