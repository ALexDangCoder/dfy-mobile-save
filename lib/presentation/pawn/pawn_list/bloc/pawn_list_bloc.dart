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
  List<bool> listFilter = [
    false,
    false,
    false,
    false,
  ];
  BehaviorSubject<List<bool>> listFilterStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);

  PawnRepository get _pawnService => Get.find();
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int MORE_THAN_FIVETY = 3;

  void funOnSearch(String value) {
    textSearch.sink.add(value);
    //todo searchCollection(value);
  }

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    //todo searchCollection(value);
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
    //todo  searchCollection('');
  }

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

  void chooseFilter({required int index}) {
    listFilter = List.filled(4, false);
    listFilter[index] = true;
    listFilterStream.sink.add(listFilter);
  }
}
