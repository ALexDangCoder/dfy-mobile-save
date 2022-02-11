import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'evaluation_hard_nft_result_state.dart';

class EvaluationHardNftResultCubit
    extends BaseCubit<EvaluationHardNftResultState> {
  EvaluationHardNftResultCubit() : super(EvaluationHardNftResultInitial());

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  void reloadAPI(String assetID) {
    const oneSec = Duration(seconds: 30);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        getListEvaluationResult(assetID);
      },
    );
  }

  Future<void> getListEvaluationResult(String assetId) async {
    getTokenInf();
    final Result<List<EvaluationResult>> result =
        await _createHardNFTRepository.getListEvaluationResult(
      assetId,
      '1',
    );
    result.when(
      success: (res) {
        final List<EvaluationResult> listCheck = [];
        for (int i = 0; i < res.length; i++) {
          if (res[i].status == 1 ||
              res[i].status == 2 ||
              res[i].status == 3 ||
              res[i].status == 4 ||
              res[i].status == 5 ||
              res[i].status == 6) {
            listCheck.add(res[i]);
          }
        }
        if (listCheck.isNotEmpty) {
          for (int i = 0; i < listCheck.length; i++) {
            for (int j = 0; j < listTokenSupport.length; j++) {
              if (listCheck[i].evaluatedSymbol == listTokenSupport[j].symbol) {
                listCheck[i].urlToken = listTokenSupport[j].iconUrl;
              }
            }
          }
        }
        emit(EvaluationResultSuccess(listCheck));
      },
      error: (error) {
        showError();
      },
    );
  }
}
