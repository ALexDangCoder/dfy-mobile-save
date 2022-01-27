import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:flutter/material.dart';

class StepAppBar extends StatelessWidget {
  const StepAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SuccessCkcCreateNft(),
        dividerSuccessCreateNFT,
        CircleStepCreateNft(
          circleStatus: CircleStatus.IS_CREATING,
          stepCreate: S.current.step2,
        ),
        dividerCreateNFT,
        CircleStepCreateNft(
          circleStatus: CircleStatus.IS_NOT_CREATE,
          stepCreate: S.current.step3,
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
