import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_detail/ui/evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluationItem extends StatelessWidget {
  const EvaluationItem({
    Key? key,
    required this.evaluationResult,
    required this.cubit,
    required this.assetID,
  }) : super(key: key);
  final EvaluationResult evaluationResult;
  final EvaluationHardNftResultCubit cubit;
  final String assetID;

  @override
  Widget build(BuildContext context) {
    final checkProcess = evaluationResult.status == 1 ||
        evaluationResult.status == 3 ||
        evaluationResult.status == 5;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EvaluationScreen(
              evaluationId: evaluationResult.evaluationId ?? '',
              isAccept: evaluationResult.status == 2,
              bcEvaluationId: evaluationResult.bcEvaluationID ?? '0',
              assetID: assetID,
            ),
            settings: const RouteSettings(
              name: AppRouter.step3ListEvaluation,
            ),
          ),
        ).whenComplete(() {
          cubit.getListEvaluationResult(assetID);
        });
      },
      child: Container(
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, top: 12.h),
              child: Row(
                children: [
                  Container(
                    height: 46.h,
                    width: 46.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          evaluationResult.avatarEvaluator ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  spaceW8,
                  SizedBox(
                    height: 40.h,
                    width: 260.w,
                    child: content(evaluationResult.status ?? 2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 18.h,
                right: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: 24.h,
                      width: 24.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(evaluationResult.urlToken ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  spaceW8,
                  Text(
                    '${evaluationResult.evaluatedPrice} '
                    '${evaluationResult.evaluatedSymbol ?? ''}',
                    style: textNormalCustom(
                      amountColor,
                      24,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            spaceH10,
            if (checkProcess)
              Padding(
                padding: EdgeInsets.only(
                  top: 5.h,
                  right: 16.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 8.h,
                      width: 8.w,
                      child: CircularProgressIndicator(
                        color: processingColor,
                        strokeWidth: 1.r,
                      ),
                    ),
                    spaceW5,
                    Text(
                      S.current.processing,
                      style: textNormalCustom(
                        processingColor,
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            spaceH10,
          ],
        ),
      ),
    );
  }

  Widget content(int status) {
    switch (status) {
      case 3:
      case 4:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.you_have,
                style: textNormalCustom(
                  textHistory,
                  16,
                  FontWeight.w600,
                ),
              ),
              TextSpan(
                text: S.current.ACCEPTED,
                style: textNormalCustom(
                  successTransactionColor,
                  16,
                  FontWeight.w600,
                ),
              ),
              TextSpan(
                text: S.current.a_hard_nft_evaluation,
                style: textNormalCustom(
                  textHistory,
                  16,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      case 1:
      case 2:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.your_hard_NFT_has_been,
                style: textNormalCustom(
                  textHistory,
                  16,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      default:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.you_have,
                style: textNormalCustom(
                  textHistory,
                  16,
                  FontWeight.w600,
                ),
              ),
              TextSpan(
                text: S.current.REJECTED,
                style: textNormalCustom(
                  failTransactionColor,
                  16,
                  FontWeight.w600,
                ),
              ),
              TextSpan(
                text: S.current.a_hard_nft_evaluation,
                style: textNormalCustom(
                  textHistory,
                  16,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        );
    }
  }
}
