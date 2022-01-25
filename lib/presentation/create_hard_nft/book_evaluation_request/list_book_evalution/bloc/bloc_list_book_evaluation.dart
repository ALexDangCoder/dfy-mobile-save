
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:rxdart/rxdart.dart';

class BlocListBookEvaluation {
  BehaviorSubject<List<PawnShopModel>> listPawnSHop =
      BehaviorSubject.seeded([]);

  void getListPawnShop() {
    List<PawnShopModel> list = [];
    list.add(
      PawnShopModel(
        date: '09:15 - 14/12/2021',
        avatar:
            'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
        namePawnShop: 'Doanh 88',
        status: 'The evaluator has rejected your evaluation request',
      ),
    );
    listPawnSHop.sink.add(list);
  }
}
