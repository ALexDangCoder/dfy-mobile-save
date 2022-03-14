import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail/ui/collateral_detail.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ItemCollateral extends StatelessWidget {
  final String address;
  final String rate;
  final String contracts;
  final String iconBorrower;
  final String iconLoadToken;
  final String iconCollateral;
  final String collateral;
  final String loadToken;
  final String duration;
  final String id;

  const ItemCollateral({
    Key? key,
    required this.address,
    required this.rate,
    required this.contracts,
    required this.iconBorrower,
    required this.collateral,
    required this.loadToken,
    required this.duration,
    required this.iconLoadToken,
    required this.iconCollateral,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 343.w,
        margin: EdgeInsets.only(
          bottom: 20.h,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().borderItemColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          border: Border.all(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
            top: 18.h,
            bottom: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.borrower}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 7,
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: textNormal(
                          null,
                          16,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                launchURL(
                                  Get.find<AppConstants>().bscScan +
                                      ApiConstants.BSC_SCAN_ADDRESS +
                                      address,
                                );
                              },
                              child: Text(
                                address.length > 11
                                    ? address.formatAddressDialog()
                                    : address,
                                style: textNormal(
                                  AppTheme.getInstance().blueColor(),
                                  16,
                                ).copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 4.w,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.network(
                              iconBorrower,
                              width: 16.sp,
                              height: 16.sp,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppTheme.getInstance().bgBtsColor(),
                                width: 16.sp,
                                height: 16.sp,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 4.w,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.asset(
                              ImageAssets.img_star,
                              width: 16.sp,
                              height: 16.sp,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 4.w,
                            ),
                          ),
                          TextSpan(
                            text: '$rate | $contracts ${S.current.contracts}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.collateral}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 7,
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: textNormal(
                          null,
                          16,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.network(
                              iconCollateral,
                              width: 16.sp,
                              height: 16.sp,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppTheme.getInstance().bgBtsColor(),
                                width: 16.sp,
                                height: 16.sp,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 4.w,
                            ),
                          ),
                          TextSpan(text: collateral),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.loan_token}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 7,
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: textNormal(
                          null,
                          16,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.network(
                              iconLoadToken,
                              width: 16.sp,
                              height: 16.sp,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              width: 4.w,
                            ),
                          ),
                          TextSpan(text: loadToken),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.duration}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 7,
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: textNormal(
                          null,
                          16,
                        ),
                        children: [
                          TextSpan(
                            text: duration,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceH24,
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CollateralDetailScreen(
                          id: id,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 103.w,
                    height: 40.h,
                    child: ButtonGold(
                      radiusButton: 16,
                      haveMargin: false,
                      title: S.current.send_offer,
                      isEnable: true,
                      fixSize: false,
                      textSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
