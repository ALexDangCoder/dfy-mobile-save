import 'package:Dfy/data/response/collection/list_category_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'category_service.g.dart';

@RestApi()
abstract class CategoryService {
  @factoryMethod
  factory CategoryService(Dio dio, {String baseUrl}) = _CategoryService;

  @GET(ApiConstants.GET_LIST_CATEGORY)
  Future<ListCategoryResponse> getListCategory();

  @GET(ApiConstants.GET_LIST_CATEGORY)
  Future<ListCategoryResponse> getCategory(
      @Query('name') String name,
      );
}
