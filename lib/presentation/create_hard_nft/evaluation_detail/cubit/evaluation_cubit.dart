import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'evaluation_state.dart';

class EvaluationCubit extends BaseCubit<EvaluationState> {
  EvaluationCubit() : super(EvaluationInitial());


  NFTRepository get _nftRepo => Get.find();

  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  Future<void> getEvaluation(String evaluationId) async {
    getTokenInf();
    final Result<Evaluation> result =
    await _nftRepo.getEvaluation(evaluationId);
    result.when(
      success: (res) {
        for(int i = 0; i<listTokenSupport.length;i++){
          if(res.evaluatedSymbol == listTokenSupport[i].symbol){
            res.urlToken = listTokenSupport[i].iconUrl;
          }
        }
        emit(DetailEvaluationResult(res));
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> getHexString() async {}
  Future<void> rejectEvaluationToBlockchain() async {}
  Future<void> acceptEvaluationToBlockchain() async {}
  Future<void> rejectEvaluationToBE() async {}
  Future<void> acceptEvaluationToBE() async {}


}
