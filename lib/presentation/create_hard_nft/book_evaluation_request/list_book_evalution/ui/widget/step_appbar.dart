import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/evaluation_hard_nft_result/ui/evaluation_result.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:flutter/material.dart';

class StepAppBar extends StatelessWidget {
  final bool isSuccess;
  final String? assetId;

  const StepAppBar({
    Key? key,
    required this.isSuccess,
    this.assetId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SuccessCkcCreateNft(),
        dividerSuccessCreateNFT,
        SizedBox(
          child: isSuccess
              ? const SuccessCkcCreateNft()
              : CircleStepCreateNft(
                  circleStatus: CircleStatus.IS_CREATING,
                  stepCreate: S.current.step2,
                ),
        ),
        dividerCreateNFT,
        SizedBox(
          child: isSuccess
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            EvaluationResult(assetID: assetId ?? ''),
                        settings: const RouteSettings(
                          name: AppRouter.step3ListEvaluation,
                        ),
                      ),
                    );
                  },
                  child: CircleStepCreateNft(
                    circleStatus: CircleStatus.IS_CREATING,
                    stepCreate: S.current.step3,
                  ),
                )
              : CircleStepCreateNft(
                  circleStatus: CircleStatus.IS_NOT_CREATE,
                  stepCreate: S.current.step3,
                ),
        ),
        dividerCreateNFT,
        CircleStepCreateNft(
          circleStatus: CircleStatus.IS_NOT_CREATE,
          stepCreate: S.current.step4,
        ),
      ],
    );
  }
}
