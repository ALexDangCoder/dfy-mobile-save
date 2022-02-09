import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleStatusProvideHardNft extends StatelessWidget {
  const CircleStatusProvideHardNft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            circleStatus: CircleStatus.IS_NOT_CREATE,
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
