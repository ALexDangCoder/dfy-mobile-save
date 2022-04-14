import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/list_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/list_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/ui/receive_hard_nft_screen.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluationResult extends StatefulWidget {
  const EvaluationResult({
    Key? key,
    required this.assetID,
    this.pageRouter,
  }) : super(key: key);

  final String assetID;
  final PageRouterHardNFT? pageRouter;

  @override
  _EvaluationResultState createState() => _EvaluationResultState();
}

class _EvaluationResultState extends State<EvaluationResult> {
  EvaluationHardNftResultCubit cubit = EvaluationHardNftResultCubit();

  @override
  void initState() {
    super.initState();
    cubit.getListEvaluationResult(widget.assetID);
    cubit.reloadAPI(widget.assetID);
  }

  @override
  void dispose() {
    cubit.close();
    cubit.timerReload.cancel();
    super.dispose();
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
            await cubit.getListEvaluationResult(widget.assetID);
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
      return BaseDesignScreen(
        text: ImageAssets.ic_close,
        isImage: true,
        title: S.current.evaluation_results,
        onRightClick: () {
          if (widget.pageRouter == PageRouterHardNFT.LIST_HARD) {
            Navigator.of(context).popUntil(
              (route) => route.settings.name == AppRouter.list_hard_mint,
            );
          } else {
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop()
              ..pop()
              ..pop()..pop();
          }
        },
        bottomBar: StreamBuilder<bool>(
          stream: cubit.checkAcceptStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return Visibility(
              visible: snapshot.data ?? false,
              child: Container(
                height: 91.h,
                color: AppTheme.getInstance().bgBtsColor(),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 16.h,
                    bottom: 16.h,
                  ),
                  child: ButtonGradient(
                    onPressed: () {
                      if (snapshot.data ?? false) {
                        goTo(
                          context,
                          ReceiveHardNFTScreen(
                            assetId: widget.assetID,
                            pageRouter: widget.pageRouter,
                          ),
                        );
                      }
                    },
                    gradient: RadialGradient(
                      center: const Alignment(0.5, -0.5),
                      radius: 4,
                      colors: AppTheme.getInstance().gradientButtonColor(),
                    ),
                    child: Text(
                      S.current.receive_hard_nft,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        child: Column(
          children: [
            spaceH24,
            step(),
            spaceH32,
            if (listEvaluation.isNotEmpty)
              RefreshIndicator(
                onRefresh: () async {
                  await cubit.getListEvaluationResult(widget.assetID);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ListEvaluation(
                    listEvaluation: listEvaluation,
                    cubit: cubit,
                    assetID: widget.assetID,
                    pageRouterHardNFT: widget.pageRouter,
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 150.h),
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage(
                        ImageAssets.img_search_empty,
                      ),
                      height: 120.h,
                      width: 120.w,
                    ),
                    SizedBox(
                      height: 17.7.h,
                    ),
                    Text(
                      S.current.no_result_found,
                      style: textNormal(
                        Colors.white54,
                        20.sp,
                      ),
                    ),
                  ],
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
      child: StreamBuilder<bool>(
        stream: cubit.checkAcceptStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          final isCheckSuccess = snapshot.data ?? false;
          return Row(
            children: [
              const SuccessCkcCreateNft(),
              dividerSuccessCreateNFT,
              GestureDetector(
                onTap: () {
                  if (widget.pageRouter == PageRouter.MARKET) {
                    Navigator.pop(context);
                  }
                },
                child: const SuccessCkcCreateNft(),
              ),
              if (isCheckSuccess) dividerSuccessCreateNFT else dividerCreateNFT,
              if (!isCheckSuccess)
                CircleStepCreateNft(
                  circleStatus: CircleStatus.IS_CREATING,
                  stepCreate: S.current.step3,
                )
              else
                const SuccessCkcCreateNft(),
              dividerCreateNFT,
              if (!isCheckSuccess)
                CircleStepCreateNft(
                  circleStatus: CircleStatus.IS_NOT_CREATE,
                  stepCreate: S.current.step4,
                )
              else
                GestureDetector(
                  onTap: () {
                    goTo(
                      context,
                      ReceiveHardNFTScreen(
                        assetId: widget.assetID,
                        pageRouter: widget.pageRouter,
                      ),
                    );
                  },
                  child: CircleStepCreateNft(
                    circleStatus: CircleStatus.IS_CREATING,
                    stepCreate: S.current.step4,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
