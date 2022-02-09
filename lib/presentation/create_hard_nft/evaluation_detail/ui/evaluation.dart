import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_detail/cubit/evaluation_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'evaluation_detail.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen(
      {Key? key, required this.evaluationId, required this.urlIcon})
      : super(key: key);
  final String evaluationId;
  final String urlIcon;

  @override
  _EvaluationScreenState createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  EvaluationCubit cubit = EvaluationCubit();

  @override
  void initState() {
    super.initState();
    cubit.getEvaluation(widget.evaluationId, widget.urlIcon);
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
      return BaseBottomSheet(
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
                  height: 530.h,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
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
            Padding(
              padding: EdgeInsets.only(top: 594.h),
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
                      child: _buildButtonReject(),
                    ),
                    SizedBox(
                      width: 23.w,
                    ),
                    Expanded(
                      child: _buildButtonAccept(),
                    ),
                  ],
                ),
              ),
            )
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

Widget _buildButtonReject() {
  return ButtonTransparent(
    child: Text(
      S.current.reject,
      style: textNormalCustom(
        AppTheme.getInstance().textThemeColor(),
        16,
        FontWeight.w700,
      ),
    ),
    onPressed: () {},
  );
}

Widget _buildButtonAccept() {
  return ButtonGradient(
    onPressed: () {},
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
