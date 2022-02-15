import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/bloc/evaluation_hard_nft_result_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListEvaluation extends StatelessWidget {
  const ListEvaluation({
    Key? key,
    required this.listEvaluation,
    required this.cubit,
    required this.assetID,
  }) : super(key: key);
  final List<EvaluationResult> listEvaluation;
  final EvaluationHardNftResultCubit cubit;
  final String assetID;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Text(
            S.current.to_mint_hard_nft_you,
            style: textNormalCustom(
              AppTheme.getInstance().grayTextColor(),
              14,
              null,
            ),
          ),
        ),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listEvaluation.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  EvaluationItem(
                    evaluationResult: listEvaluation[index],
                    cubit: cubit,
                    assetID: assetID,
                  ),
                  spaceH20,
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
