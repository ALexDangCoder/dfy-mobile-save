import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocBookEvaluation {
  BehaviorSubject<List<EvaluatorsCityModel>> list = BehaviorSubject.seeded([]);
  List<EvaluatorsCityModel>? listMap;
  List<AppointmentModel>? appointmentList;
  TypeEvaluation? type;
  String? assetId;
  String? bcAssetId;
  double? locationLat;
  double? locationLong;
  String? cityIdMap;
  String? nameMap;
  String? nameCity;

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  void checkTypeCreate(String idEva) {
    for (final AppointmentModel value in appointmentList ?? []) {
      if ((value.evaluator?.id ?? '') == idEva) {
        type = TypeEvaluation.CREATE;
        break;
      } else {
        type = TypeEvaluation.NEW_CREATE;
      }
    }
  }

  int getDate(String idEva) {
    for (final AppointmentModel value in appointmentList ?? []) {
      if ((value.evaluator?.id ?? '') == idEva) {
        return value.appointmentTime ?? 0;
      }
    }
    return 0;
  }

  Future<void> getDetailAssetHardNFT({
    required String assetId,
  }) async {
    final Result<DetailAssetHardNft> result =
        await _createHardNFTRepository.getDetailAssetHardNFT(
      assetId,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          getListPawnShopStar(cityId: res.contactCity?.countryId ?? 0);
          bcAssetId = res.bcAssetId.toString();
          locationLat = res.contactCity?.latitude ?? 0;
          locationLong = res.contactCity?.longitude ?? 0;
          cityIdMap = res.contactCity?.countryId.toString() ?? '';
          nameCity = res.contactCity?.name ?? '';
          nameMap = res.contactCountry?.name ?? '';
        }
      },
      error: (error) {},
    );
  }

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
          listMap = res;
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
