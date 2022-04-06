import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/response/home_pawn/send_offer_lend_crypto_response.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/base_items/custom_hide_keyboard.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageLoanPackageList extends StatefulWidget {
  const ManageLoanPackageList({Key? key}) : super(key: key);

  @override
  _ManageLoanPackageListState createState() => _ManageLoanPackageListState();
}

class _ManageLoanPackageListState extends State<ManageLoanPackageList> {
  @override
  Widget build(BuildContext context) {
    return CustomGestureDetectorOnTapHideKeyBoard(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 375.w,
            height: 812.h,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                _header(),
                Divider(
                  color: AppTheme.getInstance().divideColor(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH24,
                        Text(
                          S.current.lending_setting.toUpperCase(),
                          style: textNormalCustom(
                            AppTheme.getInstance().unselectedTabLabelColor(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        spaceH20,
                        _lenderSettingItem(),
                        spaceH32,
                        Text(
                          S.current.loan_package.toUpperCase(),
                          style: textNormalCustom(
                            AppTheme.getInstance().unselectedTabLabelColor(),
                            14,
                            FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _header() {
    return SizedBox(
      height: 64.h,
      child: SizedBox(
        height: 28.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  //todo
                },
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: Image.asset(ImageAssets.ic_menu),
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: Align(
                child: Text(
                  S.current.manage_loan_package,
                  textAlign: TextAlign.center,
                  style: titleText(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 39.w,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _lenderSettingItem() {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        image: const DecorationImage(
          image: AssetImage(ImageAssets.bg_manage_loan_package_list),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Column(
              children: [
                Text(
                  S.current.description_manage_loan_1,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                Text(
                  S.current.description_manage_loan_2,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                spaceH13,
                Container(
                  width: 165.w,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: ButtonGold(
                    title: S.current.add_lend_setting,
                    isEnable: true,
                    fixSize: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
