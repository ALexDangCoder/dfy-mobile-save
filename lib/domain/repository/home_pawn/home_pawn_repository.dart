import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/nfts_collateral_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_item_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_rate_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_sale_pawnshop_item_model.dart';

mixin HomePawnRepository {
  Future<Result<List<OfficialPawnItemModel>>> getOfficialPawnShopWithNewToken();

  Future<Result<List<TopRateLenderModel>>> getTopRateLenders();

  Future<Result<List<TopSalePawnShopItemModel>>> getTopSalePawnShopPackage();

  Future<Result<List<NftsCollateralPawnModel>>> getNftsCollateralPawn();
}
