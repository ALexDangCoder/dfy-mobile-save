import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocBookEvaluation {
  BehaviorSubject<List<EvaluatorsCityModel>> list = BehaviorSubject.seeded([]);

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  Future<void> getListPawnShopStar({
    required int cityId,
  }) async {
    final Result<List<EvaluatorsCityModel>> result =
        await _createHardNFTRepository.getListAppointmentWithCity(
      cityId,
    );

    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          list.sink.add(res);
        } else {
          list.sink.add([]);
        }
      },
      error: (error) {
        list.sink.add([]);
      },
    );
  }
}
