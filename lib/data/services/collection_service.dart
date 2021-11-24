import 'package:Dfy/data/response/collection/collection_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'collection_service.g.dart';

@RestApi()
abstract class CollectionClient {

  @factoryMethod
  factory CollectionClient(Dio dio, {String baseUrl}) = _CollectionClient;

  @GET('https://619b3a7c2782760017445466.mockapi.io/collection')
  Future<List<CollectionRespone>> getCollection();
}
