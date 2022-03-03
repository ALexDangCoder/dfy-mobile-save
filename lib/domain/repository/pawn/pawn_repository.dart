import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';

mixin PawnRepository {
  Future<Result<List<PawnShopModel>>> getListPawnShop();
}
