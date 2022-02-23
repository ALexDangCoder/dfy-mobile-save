import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class BlocListBookEvaluation {
  static const int OPEN = 1;
  static const int REJECTED = 3;
  static const int ACCEPTED = 7;
  static const int SUCCESS = 9;
  static const int CANCELLED = 5;
  late Timer timeReload;

  List<AppointmentModel> appointmentList = [];

  BehaviorSubject<List<AppointmentModel>> listPawnShop = BehaviorSubject();
  bool isCancel = true;
  bool isDetail = false;
  bool isLoadingText = false;
  String? assetId;
  String? bcAssetId;
  String? hexString;
  TypeEvaluation type = TypeEvaluation.CREATE;

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();
  final Web3Utils web3utils = Web3Utils();
  BehaviorSubject<bool> isSuccess = BehaviorSubject.seeded(false);

  Future<void> getHexString({
    required String appointmentId,
    required String reason,
  }) async {
    hexString = await web3utils.getCancelAppointmentData(
      appointmentId: appointmentId,
      reason: reason,
    );
  }

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
      return amountColor;
    }
  }

  void reloadAPI() {
    const oneSec = Duration(seconds: 30);
    timeReload = Timer.periodic(
      oneSec,
      (Timer timer) {
        getListPawnShop(assetId: assetId ?? '');
      },
    );
  }

  void closeReload() {
    timeReload.cancel();
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
          bcAssetId = res.bcAssetId.toString();
        }
      },
      error: (error) {},
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

  void getIdEva(AppointmentModel eva) {
    switch (eva.status) {
      case CANCELLED:
        break;
      case REJECTED:
        break;
      default:
        appointmentList.add(eva);
    }
  }

  bool getCheckStatusEva(int status) {
    switch (status) {
      case CANCELLED:
        return false;
      case REJECTED:
        return false;
      default:
        return true;
    }
  }

  TypeEvaluation checkStatus(String idEvaluator) {
    for (final AppointmentModel value in listPawnShop.value) {
      if (value.evaluator?.id == idEvaluator) {
        if (getCheckStatusEva(value.status ?? 0)) {
          return type = TypeEvaluation.CREATE;
        }
      }
    }
    return type = TypeEvaluation.NEW_CREATE;
  }

  bool checkStatusList() {
    for (final AppointmentModel value in listPawnShop.value) {
      if (checkIsLoading(value.status ?? 0)) {
        return false;
      }
    }
    return true;
  }

  String getTextStatus(int status, int time) {
    switch (status) {
      case OPEN:
        isCancel = true;
        isDetail = false;
        isLoadingText = false;
        return S.current.your_appointment_request;
      case REJECTED:
        isDetail = true;
        isCancel = false;
        isLoadingText = false;
        return S.current.the_evaluator_has_rejected;
      case ACCEPTED:
        isDetail = false;
        isCancel = true;
        isLoadingText = false;
        if (time != 0) {
          return S.current.evaluator_has_suggested;
        } else {
          return S.current.the_evaluator_has_accepted;
        }
      case SUCCESS:
        isDetail = false;
        isCancel = false;
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
        return S.current.you_have_rejected;
      default:
        isDetail = false;
        isCancel = true;
        isLoadingText = true;
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
          if (res.status == CANCELLED) {}
        }
      },
      error: (error) {},
    );
  }

  bool checkIsSuccess(List<AppointmentModel> list) {
    for (final AppointmentModel value in list) {
      if (value.status == SUCCESS) {
        return true;
      }
    }
    return false;
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
          appointmentList.clear();
          listPawnShop.sink.add(res);
          isSuccess.sink.add(checkIsSuccess(res));
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
