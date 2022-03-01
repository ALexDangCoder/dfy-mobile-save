import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/pawn/pawn_repository.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PawnListBloc {
  TypeFilter? typeRating = TypeFilter.HIGH_TO_LOW;
  TypeFilter? typeInterest = TypeFilter.LOW_TO_HIGH;
  TypeFilter? typeSigned = TypeFilter.HIGH_TO_LOW;
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<List<PawnShopModel>> list = BehaviorSubject.seeded([]);

  PawnRepository get _pawnService => Get.find();

  Future<void> getListPawn() async {
    Result<List<PawnShopModel>> result = await _pawnService.getListPawnShop();
    result.when(
      success: (response) {
        if (response.isNotEmpty) {
          list.add(response);
        } else {}
      },
      error: (error) {},
    );
  }
}
