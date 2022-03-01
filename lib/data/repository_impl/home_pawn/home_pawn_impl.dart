import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/data/response/home_pawn/top_rate_lenders_res.dart';
import 'package:Dfy/data/response/home_pawn/top_sale_pawnshop_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/home_pawn/home_pawn_service.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_item_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_rate_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_sale_pawnshop_item_model.dart';
import 'package:Dfy/domain/repository/home_pawn/home_pawn_repository.dart';

class HomePawnRepositoryImpl implements HomePawnRepository {
  final HomePawnService _homePawnService;

  HomePawnRepositoryImpl(this._homePawnService);

  @override
  Future<Result<List<OfficialPawnItemModel>>>
      getOfficialPawnShopWithNewToken() {
    return runCatchingAsync<OfficialPawnWithNewTokenResponse,
        List<OfficialPawnItemModel>>(
      () => _homePawnService.getOfficialPawn(),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TopRateLenderModel>>> getTopRateLenders() {
    return runCatchingAsync<TopRateLendersResponse, List<TopRateLenderModel>>(
      () => _homePawnService.getTopRatedLenders(),
      (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<TopSalePawnShopItemModel>>> getTopSalePawnShopPackage() {
    return runCatchingAsync<TopSalePawnShopPackageResponse, List<TopSalePawnShopItemModel>>(
          () => _homePawnService.getTopSalePackage(),
          (response) => response.data?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
