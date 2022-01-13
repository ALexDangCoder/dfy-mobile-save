import 'package:Dfy/data/di/flutter_transformer.dart';
import 'package:Dfy/data/repository_impl/category_repository_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/collection_detail_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/collection_filter_repository_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/detail_category_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/login_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/marketplace_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/nft_market_repository_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/nonce_impl.dart';
import 'package:Dfy/data/repository_impl/nft_repository_impl.dart';
import 'package:Dfy/data/repository_impl/price_repository_impl.dart';
import 'package:Dfy/data/repository_impl/search_market/search_market_impl.dart';
import 'package:Dfy/data/repository_impl/token_repository_impl.dart';
import 'package:Dfy/data/services/market_place/category_service.dart';
import 'package:Dfy/data/services/market_place/collection_detail_service.dart';
import 'package:Dfy/data/services/market_place/collection_filter_service.dart';
import 'package:Dfy/data/services/market_place/detail_category_service.dart';
import 'package:Dfy/data/services/market_place/login_service.dart';
import 'package:Dfy/data/services/market_place/marketplace_client.dart';
import 'package:Dfy/data/services/market_place/nft_market_services.dart';
import 'package:Dfy/data/services/market_place/nonce_service.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/data/services/price_service.dart';
import 'package:Dfy/data/services/search_market/search_market_client.dart';
import 'package:Dfy/data/services/token_service.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/domain/repository/market_place/nonce_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
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
  //nonce
  Get.put(NonceClient(provideDio()));
  Get.put<NonceRepository>(
    NonceImpl(Get.find()),
  );
  //login
  Get.put(LoginClient(provideDio()));
  Get.put<LoginRepository>(
    LoginImpl(Get.find()),
  );
  Get.put(SearchMarketClient(provideDio()));
  Get.put<SearchMarketRepository>(SearchMarketImpl(Get.find()));
  Get.put(CategoryService(provideDio()));
  Get.put<CategoryRepository>(
    CategoryRepositoryImpl(Get.find()),
  );
  Get.put(CollectionFilterClient(provideDio()));
  Get.put<CollectionFilterRepository>(CollectionFilterImpl(Get.find()));
  Get.put(NftMarketClient(provideDio()));
  Get.put<NftMarketRepository>(NftMarketRepositoryImpl(Get.find()));
  Get.put(NFTClient(provideDio()));
  Get.put<NFTRepository>(NFTRepositoryImpl(Get.find()));

  Get.put(NFTClient(provideDio()));
  Get.put<NFTRepository>(NFTRepositoryImpl(Get.find()));
  Get.put(CollectionDetailService(provideDio()));
  Get.put<CollectionDetailRepository>(CollectionDetailImpl(Get.find()));

  // get detail category

  Get.put(DetailCategoryClient(provideDio(connectionTimeOut: 40000)));
  Get.put<DetailCategoryRepository>(DetailCategoryRepositoryImpl(Get.find()));
}

Dio provideDio({int connectionTimeOut = 60000}) {
  final appConstants = Get.find<AppConstants>();
  final options = BaseOptions(
    baseUrl: appConstants.baseUrl,
    receiveTimeout: connectionTimeOut,
    connectTimeout: connectionTimeOut,
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
        options.headers = {
          'pinata_api_key': 'ac8828bff3bcd1c1b828',
          'pinata_secret_api_key':
              'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df',
          'headers':'dmbe',
          'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ3YWxsZ'
              'XRfYWRkcmVzcyI6IjB4YWIwNWFiNzljMGY0NDBhZDk4MmIxNDA1NTM2YWJjODA5N'
              'GM4MGFmYiIsImdyYW50X3R5cGUiOiJ3YWxsZXQiLCJ1c2VyX25hbWUiOiIweGF'
              'iMDVhYjc5YzBmNDQwYWQ5ODJiMTQwNTUzNmFiYzgwOTRjODBhZmIiLCJzY29wZS'
              'I6WyJERUZBVUxUIl0sImV4cCI6MTY0MjA3NjgxMiwianRpIjoiYjNhYTkyNGYt'
              'ZGVmZC00YzYxLTgyZGYtY2RiYThlMWM1ODNlIiwiY2xpZW50X2lkIjoidGFpbmQ'
              'ifQ.CPDpOdnPYHTVCbBPxT4OzTT57rvSGxbGDUSux7X7g2JcHu_rL-2vjeONXk'
              'vWxQfi5HREwtCcUbsCMCvicZt7pTRc8CGbBC8Ep4oAqaQRV3tE8KMytVoZXxeO'
              'nK1JjrNlD6vjjcSRF6XsUoaT2gHK73EUZJ96W9a5FZnGLnPLsEwmNKP9ijXG'
              '_ZmA0tSgCKdLMGWNDJofmLsZ1ykmFQrc7HLhFCic7X4zkn8OtWLfdh4MWaNnDhi'
              'XmokB6n6_fFQPsx0tSWOI89BOUV0kd5b5mN1HTC4LEj_xhK8yDt0ffjZBpcI8tg'
              'KJl_DU26CXtNS92JAIwBO8dybZwYA7NLgn4g'
        };
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
