import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'detail_category_service.g.dart';

@RestApi()
abstract class DetailCategoryClient {

  factory DetailCategoryClient(Dio dio, {String baseUrl}) = _DetailCategoryClient;
}