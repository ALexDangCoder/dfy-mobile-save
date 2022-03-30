import 'package:Dfy/data/di/flutter_transformer.dart';
import 'package:Dfy/data/repository_impl/category_repository_impl.dart';
import 'package:Dfy/data/repository_impl/hard_nft_my_account/step1/step_1_repositoy_impl.dart';
import 'package:Dfy/data/repository_impl/home_pawn/borrow_repository_impl.dart';
import 'package:Dfy/data/repository_impl/home_pawn/home_pawn_impl.dart';
import 'package:Dfy/data/repository_impl/home_pawn/user_profile_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/collection_detail_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/collection_filter_repository_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/confirm_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/create_hard_nft_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/detail_category_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/login_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/marketplace_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/nft_market_repository_impl.dart';
import 'package:Dfy/data/repository_impl/market_place/wallet_address_impl.dart';
import 'package:Dfy/data/repository_impl/nft_repository_impl.dart';
import 'package:Dfy/data/repository_impl/pawn/lender_contract/lender_contract_repo_impl.dart';
import 'package:Dfy/data/repository_impl/pawn/offer_sent/offer_sent_repo_impl.dart';
import 'package:Dfy/data/repository_impl/pinata/pinata_repository_impl.dart';
import 'package:Dfy/data/repository_impl/search_market/search_market_impl.dart';
import 'package:Dfy/data/repository_impl/token_repository_impl.dart';
import 'package:Dfy/data/services/hard_nft_my_account/step1/step_1_service.dart';
import 'package:Dfy/data/services/home_pawn/borrow_service.dart';
import 'package:Dfy/data/services/home_pawn/home_pawn_service.dart';
import 'package:Dfy/data/services/home_pawn/user_profile_service.dart';
import 'package:Dfy/data/services/market_place/category_service.dart';
import 'package:Dfy/data/services/market_place/collection_detail_service.dart';
import 'package:Dfy/data/services/market_place/collection_filter_service.dart';
import 'package:Dfy/data/services/market_place/confirm_service.dart';
import 'package:Dfy/data/services/market_place/create_hard_nft_service.dart';
import 'package:Dfy/data/services/market_place/detail_category_service.dart';
import 'package:Dfy/data/services/market_place/login_service.dart';
import 'package:Dfy/data/services/market_place/marketplace_client.dart';
import 'package:Dfy/data/services/market_place/nft_market_services.dart';
import 'package:Dfy/data/services/market_place/wallet_address_client.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/data/services/pawn/lender_contract/lender_contract_service.dart';
import 'package:Dfy/data/services/pawn/offer_sent_list/offer_sent_service.dart';
import 'package:Dfy/data/services/pinata/pinata_service.dart';
import 'package:Dfy/data/services/search_market/search_market_client.dart';
import 'package:Dfy/data/services/token_service.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/home_pawn_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/domain/repository/pawn/lender_contract/lender_contract_repository.dart';
import 'package:Dfy/domain/repository/pawn/offer_sent/offer_sent_repository.dart';
import 'package:Dfy/domain/repository/pinata/pinata_repository.dart';
import 'package:Dfy/domain/repository/search_market/search_market_repository.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void configureDependencies() {
  Get.put(TokenClient(provideDioDFY()));
  Get.put<TokenRepository>(TokenRepositoryImpl(Get.find()));
  Get.put(MarketPlaceHomeClient(provideDioDFY()));
  Get.put<MarketPlaceRepository>(
    MarketPlaceImpl(Get.find()),
  );
  //login
  Get.put(LoginClient(provideDioDFY()));
  Get.put<LoginRepository>(
    LoginImpl(Get.find()),
  );
  Get.put(SearchMarketClient(provideDioDFY()));
  Get.put<SearchMarketRepository>(SearchMarketImpl(Get.find()));
  Get.put(CategoryService(provideDioDFY()));
  Get.put<CategoryRepository>(
    CategoryRepositoryImpl(Get.find()),
  );
  Get.put(CollectionFilterClient(provideDioDFY()));
  Get.put<CollectionFilterRepository>(CollectionFilterImpl(Get.find()));
  Get.put(NftMarketClient(provideDioDFY()));
  Get.put<NftMarketRepository>(NftMarketRepositoryImpl(Get.find()));
  Get.put(NFTClient(provideDioDFY()));
  Get.put<NFTRepository>(NFTRepositoryImpl(Get.find()));

  Get.put(NFTClient(provideDioDFY()));
  Get.put<NFTRepository>(NFTRepositoryImpl(Get.find()));
  Get.put(CollectionDetailService(provideDioDFY()));
  Get.put<CollectionDetailRepository>(CollectionDetailImpl(Get.find()));

  // get detail category

  Get.put(DetailCategoryClient(provideDioDFY(connectionTimeOut: 40000)));
  Get.put<DetailCategoryRepository>(DetailCategoryRepositoryImpl(Get.find()));

  //get confirm (cancal sale, cancelpawn,....)
  Get.put(ConfirmClient(provideDioDFY()));
  Get.put<ConfirmRepository>(ConfirmImplement(Get.find()));

  Get.put(WalletAddressClient(provideDioDFY()));
  Get.put<WalletAddressRepository>(WalletAddressImpl(Get.find()));
  //create hard nft

  Get.put(CreateHardNFtService(provideDioDFY()));
  Get.put<CreateHardNFTRepository>(CreateHardNFTImpl(Get.find()));

  //hard_Nft_my_account
  Get.put(Step1Client(provideDioDFY()));
  Get.put<Step1Repository>(Step1RepositoryImpl(Get.find()));

  //pinata
  Get.put(PinataClient(provideDioPinata()));
  Get.put<PinataRepository>(PinataRepositoryImpl(Get.find()));
  //pawn service

  //pawn
  Get.put(HomePawnService(provideDioDFY()));
  Get.put<HomePawnRepository>(HomePawnRepositoryImpl(Get.find()));

  Get.put(BorrowService(provideDioDFY()));
  Get.put<BorrowRepository>(BorrowRepositoryImpl(Get.find()));

  Get.put(OfferSentService(provideDioDFY()));
  Get.put<OfferSentRepository>(OfferSentRepositoryImplement(Get.find()));
  Get.put(UserProfileService(provideDioDFY()));
  Get.put<UsersRepository>(UserProfileRepositoryImpl(Get.find()));

  Get.put(LenderContractService(provideDioDFY()));
  Get.put<LenderContractRepository>(
      LenderContractRepositoryImplement(Get.find()));
}

Dio provideDioDFY({int connectionTimeOut = 60000}) {
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
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.baseUrl = appConstants.baseUrl;

        final walletLoginJson = PrefsService.getWalletLogin();
        final accessToken = loginFromJson(walletLoginJson).accessToken ?? '';
        options.headers['Authorization'] = 'Bearer $accessToken';
        options.headers['Content-Type'] = 'application/json';
        options.headers['pinata_api_key'] = ApiConstants.PINATA_API_KEY;
        options.headers['pinata_secret_api_key'] =
            ApiConstants.PINATA_SECRET_API_KEY;
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

Dio provideDioPinata({int connectionTimeOut = 60000}) {
  final appConstants = Get.find<AppConstants>();
  final options = BaseOptions(
    baseUrl: appConstants.baseUrlPinata,
    receiveTimeout: connectionTimeOut,
    connectTimeout: connectionTimeOut,
    followRedirects: false,
  );
  final dio = Dio(options);
  dio.transformer = FlutterTransformer();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.baseUrl = appConstants.baseUrlPinata;
        options.headers['pinata_api_key'] = ApiConstants.PINATA_API_KEY;
        options.headers['pinata_secret_api_key'] =
            ApiConstants.PINATA_SECRET_API_KEY;
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
