import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_detail.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/list_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'no_evaulation_result.dart';

class EvaluationResult extends StatefulWidget {
  const EvaluationResult({Key? key}) : super(key: key);

  @override
  _EvaluationResultState createState() => _EvaluationResultState();
}

class _EvaluationResultState extends State<EvaluationResult> {
  late EvaluationHardNftResultCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = EvaluationHardNftResultCubit();
    cubit.getListEvaluationResult('6201cc4f4aec3d7ec50a748e');
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.evaluation_results,
      child: Column(
        children: [
          spaceH24,
          step(),
          SizedBox(
            child: SingleChildScrollView(
              child: BlocBuilder<EvaluationHardNftResultCubit,
                  EvaluationHardNftResultState>(
                bloc: cubit,
                builder: (context, state) {
                  return StateStreamLayout(
                    stream: cubit.stateStream,
                    error: AppException(
                        S.current.error, S.current.something_went_wrong),
                    retry: () async {},
                    textEmpty: '',
                    child: content(state),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget content(EvaluationHardNftResultState state) {
    if (state is EvaluationResultSuccess) {
      return ListEvaluation(
        listEvaluation: [],
        cubit: cubit,
      );
    } else if (state is DetailEvaluationResult) {
      return const EvaluationDetail();
    } else {
      return const NoEvaluationResultWidget();
    }
  }

  Widget step() {
    return SizedBox(
      height: 30.h,
      width: 318.w,
      child: Row(
        children: [
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
            stepCreate: '1',
          ),
          dividerCreateNFT,
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
            stepCreate: '2',
          ),
          dividerCreateNFT,
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_NOT_CREATE,
            stepCreate: '3',
          ),
          dividerCreateNFT,
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_NOT_CREATE,
            stepCreate: '4',
          ),
        ],
      ),
    );
  }
}
