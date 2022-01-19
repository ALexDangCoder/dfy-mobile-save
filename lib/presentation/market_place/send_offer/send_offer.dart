import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/base_items/base_drop_down.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<Map<String, String>> listValue = [
  {
    'value': ID_MONTH,
    'label': S.current.month,
  },
  {
    'value': ID_MONTH,
    'label': S.current.week,
  }
];

class SendOffer extends StatelessWidget {
  const SendOffer({Key? key, required this.nftOnPawn}) : super(key: key);
  final NftOnPawn nftOnPawn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BaseBottomSheet(
        title: S.current.send_offer,
        isImage: true,
        text: ImageAssets.ic_close,
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.message,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        hintText: S.current.enter_msg,
                        textValue: (value) {},
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        S.current.loan_amount,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        textValue: (value) {},
                        hintText: S.current.enter_loan_amount,
                        inputType: TextInputType.number,
                        suffix: SizedBox(
                          width: 65.w,
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child:
                                      Image.network(nftOnPawn.urlToken ?? ''),
                                ),
                                spaceW4,
                                Text(
                                  nftOnPawn.expectedCollateralSymbol ?? '',
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    14.sp,
                                    FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        S.current.interest_rate,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        textValue: (value) {},
                        hintText: S.current.enter_interest_rate,
                        inputType: TextInputType.number,
                        suffix: SizedBox(
                          width: 20.w,
                          child: Center(
                            child: Text(
                              '%',
                              style: textNormalCustom(
                                AppTheme.getInstance().textThemeColor(),
                                14.sp,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        S.current.duration,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        textValue: (value) {},
                        hintText: S.current.enter_duration,
                        suffix: SizedBox(
                          width: 100.w,
                          child: Center(
                            child: CustomDropDown(
                              listValue: listValue,
                            ),
                          ),
                        ),
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        S.current.repayment_curr,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        textValue: (value) {},
                        hintText: S.current.enter_repayment_curr,
                        suffix: SizedBox(
                          width: 20.w,
                          child: Center(
                            child: Text(
                              nftOnPawn.loanSymbol ?? '',
                              style: textNormalCustom(
                                AppTheme.getInstance().textThemeColor(),
                                14.sp,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        S.current.recurring_interest,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14.sp,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH4,
                      CustomForm(
                        textValue: (value) {},
                        hintText: S.current.enter_interest_rate,
                        suffix: SizedBox(),
                        inputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {},
              child: ButtonGold(
                title: S.current.send_offer,
                isEnable: true,
              ),
            ),
            spaceH38,
          ],
        ),
      ),
    );
  }
}
