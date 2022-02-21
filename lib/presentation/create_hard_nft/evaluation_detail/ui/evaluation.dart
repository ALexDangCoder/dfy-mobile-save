import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_detail/cubit/evaluation_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_result.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'evaluation_detail.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({
    Key? key,
    required this.evaluationId,
    required this.isAccept,
    required this.bcEvaluationId,
    required this.assetID,
  }) : super(key: key);
  final String evaluationId;
  final String bcEvaluationId;
  final bool isAccept;
  final String assetID;

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  EvaluationCubit cubit = EvaluationCubit();

  @override
  void initState() {
    super.initState();
    cubit.getTokenInf();
    cubit.getEvaluation(widget.evaluationId);
    cubit.getEvaluationFee();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvaluationCubit, EvaluationState>(
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {},
          textEmpty: '',
          child: content(state),
        );
      },
    );
  }

  Widget content(EvaluationState state) {
    if (state is DetailEvaluationResult) {
      final Evaluation evaluation = state.evaluation;
      return BaseDesignScreen(
        text: ImageAssets.ic_close,
        isImage: true,
        title: S.current.evaluation_results,
        onRightClick: () {},
        child: Stack(
          children: [
            Column(
              children: [
                spaceH24,
                step(),
                spaceH32,
                SizedBox(
                  height: widget.isAccept ? 530.h : 595.h,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: EvaluationDetail(
                        evaluation: evaluation,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.isAccept)
              Padding(
                padding: EdgeInsets.only(top: 595.h),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  height: 91.h,
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                    border: Border.all(
                      color: AppTheme.getInstance().divideColor(),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildButtonReject(
                          context,
                          evaluation,
                          cubit,
                          widget.bcEvaluationId,
                          widget.assetID,
                        ),
                      ),
                      SizedBox(
                        width: 23.w,
                      ),
                      Expanded(
                        child: _buildButtonAccept(
                          context,
                          evaluation,
                          cubit,
                          widget.bcEvaluationId,
                          widget.assetID,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
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
          const SuccessCkcCreateNft(),
          dividerSuccessCreateNFT,
          const SuccessCkcCreateNft(),
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

Widget _buildButtonReject(
  BuildContext context,
  Evaluation evaluation,
  EvaluationCubit cubit,
  String bcID,
  String assetID,
) {
  return ButtonTransparent(
    child: Text(
      S.current.reject,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
    onPressed: () async {
      final hexString = await cubit.rejectEvaluationToBlockchain(bcID);
      goTo(
        context,
        Approve(
          hexString: hexString,
          onSuccessSign: (context, data) async {
            /// PUT REJECT TO BE
            await cubit.rejectEvaluationToBE(
                bcTxnHash: hexString, evaluationID: evaluation.id ?? '');
            showLoadSuccess(context).then(
              (value) => Navigator.of(context)
                  .popUntil((route) {
                return route.settings.name ==
                    AppRouter.step3ListEvaluation;
                }),
            );
          },
          onErrorSign: (context) {
            showLoadFail(context);
          },
          listDetail: [
            DetailItemApproveModel(
              title: '${S.current.hard_nft_type}:',
              value: getNFTType(evaluation.assetType?.id ?? 7),
            ),
            DetailItemApproveModel(
              title: '${S.current.evaluation_}:',
              value: evaluation.evaluator?.name ?? '',
            ),
            DetailItemApproveModel(
              title: '${S.current.nft_name}:',
              value: evaluation.evaluator?.name ?? '',
            ),
          ],
          title: S.current.book_appointment,
          textActiveButton: S.current.reject,
          spender: eva_dev2,
        ),
      );
    },
  );
}

String getNFTType(int type) {
  switch (type) {
    case 0:
      return S.current.jewelry;
    case 1:
      return S.current.art_work;
    case 2:
      return S.current.car;
    case 3:
      return S.current.watch;
    case 4:
      return S.current.house;
    default:
      return S.current.jewelry;
  }
}

Widget _buildButtonAccept(BuildContext context, Evaluation evaluation,
    EvaluationCubit cubit, String bcID, String assetID) {
  return ButtonGradient(
    onPressed: () async {
      final hexString = await cubit.acceptEvaluationToBlockchain(bcID);
      goTo(
        context,
        Approve(
          hexString: hexString,
          onSuccessSign: (context, data) async {
            await cubit.acceptEvaluationToBE(
                bcTxnHash: hexString, evaluationID: evaluation.id ?? '');
            showLoadSuccess(context).then(
              (value) => Navigator.of(context)
                  .popUntil((route) {
                return route.settings.name ==
                    AppRouter.step3ListEvaluation;
              }),
            );
          },
          onErrorSign: (context) {
            showLoadFail(context);
          },
          listDetail: [
            DetailItemApproveModel(
              title: '${S.current.hard_nft_type}:',
              value: getNFTType(evaluation.assetType?.id ?? 7),
            ),
            DetailItemApproveModel(
              title: '${S.current.evaluation_}:',
              value: evaluation.evaluator?.name ?? '',
            ),
            DetailItemApproveModel(
              title: '${S.current.nft_name}:',
              value: evaluation.evaluator?.name ?? '',
            ),
            DetailItemApproveModel(
              title: '${S.current.evaluation_fee}:',
              value: '${cubit.evaluationFee.amount} '
                  '${cubit.evaluationFee.symbol ?? ''}',
            ),
          ],
          title: S.current.book_appointment,
          textActiveButton: S.current.accept_evaluation,
          needApprove: true,
          payValue: '${cubit.evaluationFee.amount}',
          tokenAddress: '${cubit.evaluationFee.address}',
          spender: eva_dev2,
        ),
      );
    },
    gradient: RadialGradient(
      center: const Alignment(0.5, -0.5),
      radius: 4,
      colors: AppTheme.getInstance().gradientButtonColor(),
    ),
    child: Text(
      S.current.accept,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
  );
}
