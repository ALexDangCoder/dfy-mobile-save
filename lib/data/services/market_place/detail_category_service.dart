import 'package:Dfy/data/response/market_place/detail_category_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'detail_category_service.g.dart';

@RestApi()
abstract class DetailCategoryClient {

  factory DetailCategoryClient(Dio dio, {String baseUrl}) = _DetailCategoryClient;

  @GET(ApiConstants.DETAIL_CATEGORY)
  Future<DetailCategoryResponse> getListCollectInCategory(
      @Query('size') int size,
      @Query('category') String category,
      @Query('page') int page,);
}