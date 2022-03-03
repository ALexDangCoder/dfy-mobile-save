import 'package:Dfy/data/response/pawn/pawn_list/pawn_list_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pawn/pawn_service.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/pawn/pawn_repository.dart';

class PawnImplement implements PawnRepository {
  final PawnService _pawnService;

  PawnImplement(this._pawnService);

  @override
  Future<Result<List<PawnShopModel>>> getListPawnShop() {
    return runCatchingAsync<PawnListResponse, List<PawnShopModel>>(
      () => _pawnService.getListPawn(),
      (response) =>
          response.data?.data?.content?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
