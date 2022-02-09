import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_detail.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/list_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
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
  EvaluationHardNftResultCubit cubit = EvaluationHardNftResultCubit();

  @override
  void initState() {
    super.initState();
    cubit.getListEvaluationResult('620213354aec3d7ec50a749c');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluationHardNftResultCubit,
        EvaluationHardNftResultState>(
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {
            await cubit.getListEvaluationResult('620213354aec3d7ec50a749c');
          },
          textEmpty: '',
          child: content(state),
        );
      },
    );
  }

  Widget content(EvaluationHardNftResultState state) {
    if (state is EvaluationResultSuccess) {
      final listEvaluation = state.list;
      return BaseBottomSheet(
        text: ImageAssets.ic_close,
        isImage: true,
        title: S.current.evaluation_results,
        child: SizedBox(
          child: Column(
            children: [
              spaceH24,
              step(),
              spaceH32,
              ListEvaluation(
                listEvaluation: listEvaluation,
                cubit: cubit,
              ),
            ],
          ),
        ),
      );
    } else if (state is DetailEvaluationResult) {
      return const EvaluationDetail();
    } else {
      return const ModalProgressHUD(
        inAsyncCall: true,
        progressIndicator: CupertinoLoading(),
        child: SizedBox(),
      );
    }
  }

  Widget step() {
    return SizedBox(
      height: 30.h,
      width: 318.w,
      child: Row(
        children: [
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATED,
            stepCreate: '1',
          ),
          dividerCreateNFT,
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATED,
            stepCreate: '2',
          ),
          dividerCreateNFT,
          const CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
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
