import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/data/response/home_pawn/top_rate_lenders_res.dart';
import 'package:Dfy/data/response/home_pawn/top_sale_pawnshop_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_pawn_service.g.dart';

@RestApi()
abstract class HomePawnService {
  @factoryMethod
  factory HomePawnService(Dio dio, {String baseUrl}) = _HomePawnService;

  @GET(ApiConstants.GET_OFFICIAL_PAWNSHOP_WITH_TOKEN)
  Future<OfficialPawnWithNewTokenResponse> getOfficialPawn();

  @GET(ApiConstants.GET_TOP_RATED_LENDERS)
  Future<TopRateLendersResponse> getTopRatedLenders();

  @GET(ApiConstants.GET_TOP_SALE_PACKAGE_MODEL)
  Future<TopSalePawnShopPackageResponse> getTopSalePackage();
}
