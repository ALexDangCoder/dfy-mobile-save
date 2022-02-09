import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'evaluation_state.dart';

class EvaluationCubit extends BaseCubit<EvaluationState> {
  EvaluationCubit() : super(EvaluationInitial());


  NFTRepository get _nftRepo => Get.find();

  Future<void> getEvaluation(String evaluationId, String urlIcon) async {
    final Result<Evaluation> result =
    await _nftRepo.getEvaluation(evaluationId);
    result.when(
      success: (res) {
        res.urlToken = urlIcon;
        emit(DetailEvaluationResult(res));
      },
      error: (error) {
        showError();
      },
    );
  }
}
