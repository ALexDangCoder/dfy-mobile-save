import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendLoanRequestNft extends StatelessWidget {
  const SendLoanRequestNft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          radius: Radius.circular(20.r),
          borderType: BorderType.RRect,
          color: AppTheme.getInstance().dashedColorContainer(),
          child: Container(
            height: 172.h,
            width: 343.w,
            padding: EdgeInsets.only(top: 47.h),
            child: Column(
              children: [
                Image.asset(
                  ImageAssets.createNft,
                ),
                spaceH16,
                Text(
                  'Choose your NFT',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
        spaceH36,
        Text(
          'Message',
          style: textNormalCustom(
            AppTheme.getInstance().whiteColor(),
            16,
            FontWeight.w400,
          ),
        ),
        spaceH4,
        TextFieldValidator(
          hint: 'Enter message',
        ),
        spaceH16,
        Text(
          'Loan amount',
          style: textNormalCustom(
            AppTheme.getInstance().whiteColor(),
            16,
            FontWeight.w400,
          ),
        ),
        spaceH4,
        TextFieldValidator(
          hint: 'Loan amount',
        ),
        spaceH16,
        Text(
          'Duration',
          style: textNormalCustom(
            AppTheme.getInstance().whiteColor(),
            16,
            FontWeight.w400,
          ),
        ),
        spaceH4,
        TextFieldValidator(
          hint: 'month or week',
        ),
        spaceH20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                fillColor: MaterialStateProperty.all(
                    AppTheme.getInstance().fillColor()),
                activeColor: AppTheme.getInstance().activeColor(),
                // checkColor: const Colors,
                onChanged: (value) {},
                value: true,
              ),
            ),
            spaceW12,
            SizedBox(
              width: 287.w,
              child: Flexible(
                child: Text(
                  'Login to receive email notifications',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
        spaceH40,
        const ButtonGold(
          title: 'Request loan',
          isEnable: true,
        )

      ],
    );
  }
}
