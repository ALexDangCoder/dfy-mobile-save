import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocListBookEvaluation {
  static const int OPEN = 1;
  static const int REJECTED = 3; // tu choi
  static const int ACCEPTED = 7;
  static const int PROCESSING_SUCCESS = 8;
  static const int SUCCESS = 9;
  static const int CANCELLED = 5; //huy
//PROCESSING_CREATE(0),
//     OPEN(1),
//     PROCESSING_REJECT(2),
//     REJECTED(3),
//     PROCESSING_CANCEL(4),
//     CANCELLED(5),
//     PROCESSING_ACCEPT(6),
//     ACCEPTED(7),
//     PROCESSING_SUCCESS(8),
//     SUCCESS(9),
//     TIMEOUT_ACCEPTED(10),
//     TIMEOUT_OPEN(11);
  final Web3Utils web3utils = Web3Utils();

  Future<void> getHexString({
    required String appointmentId,
    required String reason,
  }) async {
    hexString = await web3utils.getCancelAppointmentData(
      appointmentId: appointmentId,
      reason: reason,
    );
  }

  BehaviorSubject<List<AppointmentModel>> listPawnShop = BehaviorSubject();
  bool isCancel = true;
  bool isDetail = false;
  bool isLoadingText = false;
  String assetID = '';
  String? hexString;
  TypeEvaluation type = TypeEvaluation.CREATE;

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
    } else if (S.current.you_have_rejected == status) {
      return AppTheme.getInstance().redMarketColors();
    } else {
      return AppTheme.getInstance().whiteColor();
    }
  }

  void reloadAPI() {
    const oneSec = Duration(seconds: 30);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        getListPawnShop(assetId: assetID);
      },
    );
  }

  bool checkIsLoading(int status) {
    switch (status) {
      case OPEN:
        return false;
      case REJECTED:
        return false;
      case ACCEPTED:
        return false;
      case SUCCESS:
        return false;
      case CANCELLED:
        return false;
      default:
        return true;
    }
  }

  String getTextStatus(int status, int time) {
    switch (status) {
      case OPEN:
        isCancel = true;
        isDetail = false;
        isLoadingText = false;
        type = TypeEvaluation.CREATE;
        return S.current.your_appointment_request;
      case REJECTED:
        isDetail = true;
        isCancel = false;
        isLoadingText = false;
        type = TypeEvaluation.NEW_CREATE;
        return S.current.the_evaluator_has_rejected;
      case ACCEPTED:
        type = TypeEvaluation.CREATE;
        isDetail = false;
        isCancel = true;
        isLoadingText = false;
        if (time != 0) {
          return S.current.evaluator_has_suggested;
        } else {
          return S.current.the_evaluator_has_accepted;
        }
      case SUCCESS:
        type = TypeEvaluation.CREATE;
        isDetail = false;
        isCancel = true;
        isLoadingText = false;
        if (time != 0) {
          return S.current.evaluator_has_suggested;
        } else {
          return S.current.the_evaluator_has_accepted;
        }
      case CANCELLED:
        isDetail = false;
        isCancel = false;
        isLoadingText = false;
        type = TypeEvaluation.NEW_CREATE;
        return S.current.you_have_rejected;
      default:
        isDetail = false;
        isCancel = true;
        isLoadingText = true;
        type = TypeEvaluation.CREATE;
        return S.current.processing_transaction;
    }
  }

  Future<void> cancelEvaluation({
    required String evaluatorId,
    required String bcTxnHashCancel,
  }) async {
    final Result<CancelEvaluationModel> result =
        await _createHardNFTRepository.cancelEvaluation(
      evaluatorId,
      bcTxnHashCancel,
    );
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          print('=--------------------------${res.status}');
          if (res.status == CANCELLED) {
            print('sucseccff');
          }
        }
      },
      error: (error) {},
    );
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
