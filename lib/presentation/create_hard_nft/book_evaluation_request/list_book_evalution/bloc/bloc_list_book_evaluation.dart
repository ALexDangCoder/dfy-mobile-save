import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocListBookEvaluation {
  static const int OPEN = 1;
  static const int REJECTED = 3; // tu choi
  static const int ACCEPTED = 7;
  static const int CANCELLED = 5; //huy

  BehaviorSubject<List<AppointmentModel>> listPawnShop = BehaviorSubject();
  bool isCancel = true;
  bool isDetail = false;

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  Color checkColor(String status) {
    if (S.current.your_appointment_request == status) {
      return AppTheme.getInstance().orangeMarketColors();
    } else if (S.current.the_evaluator_has_rejected == status) {
      return AppTheme.getInstance().redMarketColors();
    } else if (S.current.the_evaluator_has_accepted == status) {
      return AppTheme.getInstance().greenMarketColors();
    } else if (S.current.evaluator_has_suggested == status) {
      return AppTheme.getInstance().blueMarketColors();
    } else {
      return AppTheme.getInstance().redMarketColors();
    }
  }

  String getTextStatus(int status, int time) {
    switch (status) {
      case OPEN:
        isCancel = true;
        isDetail = false;
        return S.current.your_appointment_request;
      case REJECTED:
        isDetail = true;
        isCancel = false;
        return S.current.the_evaluator_has_rejected;
      case ACCEPTED:
        if (time != 0) {
          isDetail = false;
          isCancel = true;
          return S.current.evaluator_has_suggested;
        } else {
          isDetail = false;
          isCancel = true;
          return S.current.the_evaluator_has_accepted;
        }
      case CANCELLED:
        isDetail = false;
        isCancel = false;
        return S.current.you_have_rejected;
      default:
        isDetail = false;
        isCancel = true;
        return '';
    }
  }

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
