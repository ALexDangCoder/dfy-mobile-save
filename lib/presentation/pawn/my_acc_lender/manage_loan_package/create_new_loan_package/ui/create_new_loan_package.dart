import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewLoanPackage extends StatefulWidget {
  const CreateNewLoanPackage({Key? key}) : super(key: key);

  @override
  _CreateNewLoanPackageState createState() => _CreateNewLoanPackageState();
}

class _CreateNewLoanPackageState extends State<CreateNewLoanPackage> {
  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.new_loan_package,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            children: [
              spaceH22,
              _textTitle(title: S.current.type.capitalize()),
              _textTitle(title: S.current.message.capitalize()),
              _textTitle(title: S.current.loan_token.capitalize()),
              _textTitle(title: S.current.loan_amount.capitalize()),
              _textTitle(title: S.current.collateral.capitalize()),
              _textTitle(title: S.current.interest_rate.capitalize()),
              _textTitle(title: S.current.repayment_token.capitalize()),
              _textTitle(title: S.current.duration.capitalize()),
              _textTitle(title: S.current.recurring_interest.capitalize()),
              _textTitle(
                title: S.current.loan_to_value.capitalize(),
                isHaveIcWarning: true,
              ),
              _textTitle(
                title: S.current.ltv_liquid_thres.capitalize(),
                isHaveIcWarning: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textTitle({required String title, bool? isHaveIcWarning = false}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceW8,
            if (isHaveIcWarning ?? false)
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: Image.asset(
                  ImageAssets.ic_about_2,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(),
          ],
        ),
        spaceH4,
      ],
    );
  }
}
