import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocListBookEvaluation {
  BehaviorSubject<List<AppointmentModel>> listPawnShop = BehaviorSubject();

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  Future<void> getListPawnShop({
    required String assetId,
  }) async {
    final Result<List<AppointmentModel>> result =
        await _createHardNFTRepository.getListAppointment(
      assetId,
    );

    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          listPawnShop.sink.add(res);
        } else {
          listPawnShop.sink.add([]);
        }
      },
      error: (error) {
        listPawnShop.sink.add([]);
      },
    );
  }
}
