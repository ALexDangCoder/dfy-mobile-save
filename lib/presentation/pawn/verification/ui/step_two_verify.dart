import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepTwoVerify extends StatefulWidget {
  const StepTwoVerify({Key? key}) : super(key: key);

  @override
  _StepTwoVerifyState createState() => _StepTwoVerifyState();
}

class _StepTwoVerifyState extends State<StepTwoVerify> {
  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Identity documents',
      text: ImageAssets.ic_close,
      isImage: true,
      bottomBar: Container(
        height: 91.h,
        color: AppTheme.getInstance().bgBtsColor(),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 16.h,
          ),
          child: InkWell(
            onTap: () {

            },
            child: ButtonRadial(
              height: 64.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  S.current.continue_s,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onRightClick: () {
        Navigator.of(context).popUntil(
          (route) => route.settings.name == AppRouter.verify,
        );
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(child: step()),
            spaceH36,
          ],
        ),
      ),
    );
  }
  Widget step() {
    return SizedBox(
      height: 30.h,
      width: 318.w,
      child: Row(
        children: [
          const SuccessCkcCreateNft(),
          dividerVerifySuccess,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_CREATING,
            stepCreate: S.current.step2,
          ),
          dividerVerify,
          CircleStepCreateNft(
            circleStatus: CircleStatus.IS_NOT_CREATE,
            stepCreate: S.current.step3,
          ),
        ],
      ),
    );
  }
}
