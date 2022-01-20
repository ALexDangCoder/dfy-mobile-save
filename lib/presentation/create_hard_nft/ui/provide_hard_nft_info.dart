import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/item/circle_step_create_nft.dart';
import 'package:Dfy/widgets/item/successCkcCreateNft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
  IS_CREATED,
}

class ProvideHardNftInfo extends StatefulWidget {
  const ProvideHardNftInfo({Key? key}) : super(key: key);

  @override
  _ProvideHardNftInfoState createState() => _ProvideHardNftInfoState();
}

class _ProvideHardNftInfoState extends State<ProvideHardNftInfo> {
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Provide Hard NFT info',
      child: SingleChildScrollView(
        child: Column(
          children: [
            spaceH24,
            SizedBox(
              height: 30.h,
              width: 318.w,
              child: Row(
                children: [
                  CircleStepCreateNft(
                      circleStatus: CircleStatus.IS_CREATING, stepCreate: '1'),
                  dividerCreateNFT,
                  CircleStepCreateNft(
                      circleStatus: CircleStatus.IS_NOT_CREATE, stepCreate: '2'),
                  dividerCreateNFT,
                  CircleStepCreateNft(
                      circleStatus: CircleStatus.IS_NOT_CREATE, stepCreate: '3'),
                  dividerCreateNFT,
                  CircleStepCreateNft(
                      circleStatus: CircleStatus.IS_NOT_CREATE, stepCreate: '4'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
