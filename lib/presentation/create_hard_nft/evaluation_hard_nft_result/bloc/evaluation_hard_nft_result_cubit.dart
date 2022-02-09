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


  Future<void> getListEvaluationResult(String assetId) async {
    getTokenInf();
    final Result<List<EvaluationResult>> result =
    await _createHardNFTRepository.getListEvaluationResult(
      assetId,
      '1',
    );
    result.when(
      success: (res) {
        for(int i = 0;i<res.length;i++) {
          if(res[i].status !=2 || res[i].status !=4 || res[i].status !=6) {
            res.removeAt(i);
          }
          for(int j = 0;j<listTokenSupport.length;j++){
            if(res[i].evaluatedSymbol == listTokenSupport[j].symbol) {
              res[i].urlToken = listTokenSupport[j].iconUrl;
            }
          }
        }
        emit(EvaluationResultSuccess(res));
      },

      error: (error) {
        showError();
      },
    );
  }

}
