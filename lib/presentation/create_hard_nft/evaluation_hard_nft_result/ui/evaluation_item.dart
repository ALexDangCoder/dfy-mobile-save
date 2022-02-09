import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EvaluationItem extends StatelessWidget {
  const EvaluationItem(
      {Key? key, required this.evaluationResult, required this.cubit})
      : super(key: key);
  final EvaluationResult evaluationResult;
  final EvaluationHardNftResultCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 343.w,
        height: 125.h,
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
                            evaluationResult.avatarEvaluator ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  spaceW8,
                  SizedBox(
                    height: 40.h,
                    width: 260.w,
                    child: content(2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 23.h,
                right: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    child: Image(
                      image: AssetImage(ImageAssets.symbol),
                      width: 24.w,
                      height: 24.h,
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
          ],
        ),
      ),
    );
  }

  Widget content(int status) {
    switch (status) {
      case 4:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.you_have,
                style: textNormal(
                  textHistory,
                  16,
                ),
              ),
              TextSpan(
                text: S.current.accepted,
                style: textNormal(
                  successTransactionColor,
                  16,
                ),
              ),
              TextSpan(
                text: S.current.a_hard_nft_evaluation,
                style: textNormal(
                  textHistory,
                  16,
                ),
              ),
            ],
          ),
        );
      case 2:
        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.your_hard_NFT_has_been,
                style: textNormal(
                  textHistory,
                  16,
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
                style: textNormal(
                  textHistory,
                  16,
                ),
              ),
              TextSpan(
                text: S.current.rejected,
                style: textNormal(
                  failTransactionColor,
                  16,
                ),
              ),
              TextSpan(
                text: S.current.a_hard_nft_evaluation,
                style: textNormal(
                  textHistory,
                  16,
                ),
              ),
            ],
          ),
        );
    }
  }
}
