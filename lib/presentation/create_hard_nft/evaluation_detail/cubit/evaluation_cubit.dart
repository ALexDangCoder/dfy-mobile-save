import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
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

  EvaluationFee evaluationFee = EvaluationFee();

  Future<void> getEvaluationFee() async {
    final Result<List<EvaluationFee>> result =
    await _createHardNFTRepository.getEvaluationFee();
    result.when(
      success: (res) {
        if (res.isBlank ?? false) {
        } else {
          for (final value in res) {
            if (value.id == EVALUATION_FEE) {
              evaluationFee = value;
              for (int i = 0; i < listTokenSupport.length; i++) {
                if (value.symbol == listTokenSupport[i].symbol) {
                  value.address = listTokenSupport[i].address;
                }
              }
            }
          }
        }
      },
      error: (error) {},
    );
  }

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  Future<void> getEvaluation(String evaluationId) async {
    final Result<Evaluation> result =
        await _nftRepo.getEvaluation(evaluationId);
    result.when(
      success: (res) {
        for (int i = 0; i < listTokenSupport.length; i++) {
          if (res.evaluatedSymbol == listTokenSupport[i].symbol) {
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

  Web3Utils client = Web3Utils();

  Future<String> rejectEvaluationToBlockchain(String evaluationId) async {
    final String hexString =
        await client.getRejectEvaluationData(evaluationId: evaluationId);
    return hexString;
  }

  Future<String> acceptEvaluationToBlockchain(String evaluationId) async {
    final String hexString =
        await client.getAcceptEvaluationData(evaluationId: evaluationId);
    return hexString;
  }

  Future<void> rejectEvaluationToBE({
    required String bcTxnHash,
    required String evaluationID,
  }) async {
    final Result<String> code = await _createHardNFTRepository
        .confirmRejectEvaluationToBE(bcTxnHash, evaluationID);
    code.when(success: (res) {}, error: (error) {});
  }

  Future<void> acceptEvaluationToBE({
    required String bcTxnHash,
    required String evaluationID,
  }) async {
    final Result<String> code = await _createHardNFTRepository
        .confirmAcceptEvaluationToBE(bcTxnHash, evaluationID);
    code.when(success: (res) {}, error: (error) {});
  }
}
