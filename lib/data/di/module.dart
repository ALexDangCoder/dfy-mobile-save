import 'package:Dfy/data/di/flutter_transformer.dart';
import 'package:Dfy/data/repository_impl/market_place/marketplace_impl.dart';
import 'package:Dfy/data/repository_impl/price_repository_impl.dart';
import 'package:Dfy/data/repository_impl/search_market/search_market_impl.dart';
import 'package:Dfy/data/repository_impl/token_repository_impl.dart';
import 'package:Dfy/data/services/market_place/marketplace_client.dart';
import 'package:Dfy/data/services/price_service.dart';
import 'package:Dfy/data/services/search_market/search_market_client.dart';
import 'package:Dfy/data/services/token_service.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/domain/repository/price_repository.dart';
import 'package:Dfy/domain/repository/search_market/search_market_repository.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void configureDependencies() {
  Get.put(TokenClient(provideDio()));
  Get.put<TokenRepository>(TokenRepositoryImpl(Get.find()));
  Get.put(PriceClient(provideDio()));
  Get.put<PriceRepository>(PriceRepositoryImpl(Get.find()));
  Get.put(MarketPlaceHomeClient(provideDio()));
  Get.put<MarketPlaceRepository>(
    MarketPlaceImpl(Get.find()),
  );
  Get.put(SearchMarketClient(provideDio()));
  Get.put<SearchMarketRepository>(SearchMarketImpl(Get.find()));
}

int _connectTimeOut = 60000;

Dio provideDio() {
  final appConstants = Get.find<AppConstants>();
  final options = BaseOptions(
    baseUrl: appConstants.baseUrl,
    receiveTimeout: _connectTimeOut,
    connectTimeout: _connectTimeOut,
    followRedirects: false,
  );
  final dio = Dio(options);
  dio.transformer = FlutterTransformer();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = appConstants.baseUrl;
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) => handler.next(e),
    ),
  );
  if (Foundation.kDebugMode) {
    dio.interceptors.add(dioLogger());
  }
  return dio;
}

PrettyDioLogger dioLogger() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    maxWidth: 100,
  );
}
