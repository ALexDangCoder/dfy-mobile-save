import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/confirm_blockchain_category.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_without_prefix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendOffer extends StatefulWidget {
  const SendOffer({Key? key}) : super(key: key);

  @override
  _SendOfferState createState() => _SendOfferState();
}

class _SendOfferState extends State<SendOffer> {
  late final TextEditingController _txtMessage;
  late final TextEditingController _txtLoanToVl;
  late final TextEditingController _txtLoanAmount;
  late final TextEditingController _txtInterestRate;
  late final TextEditingController _txtLiquidationThr;
  late final TextEditingController _txtDuration;
  late final TextEditingController _txtRepaymentCurrency;
  late final TextEditingController _txtRecurringInterest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _txtMessage = TextEditingController();
    _txtLoanToVl = TextEditingController();
    _txtLoanAmount = TextEditingController();
    _txtInterestRate = TextEditingController();
    _txtLiquidationThr = TextEditingController();
    _txtDuration = TextEditingController();
    _txtRepaymentCurrency = TextEditingController();
    _txtRecurringInterest = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Align(
          alignment: Alignment.bottomCenter,
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
                            S.current.quantity,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14.sp,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH4,
                          FormWithOutPrefix(
                            hintText: S.current.enter_msg,
                            typeForm: TypeFormWithoutPrefix.TEXT,
                            cubit: '',
                            txtController: _txtMessage,
                            quantityOfAll: 10,
                            isTokenOrQuantity: false,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            S.current.loan_to_vl,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14.sp,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH4,
                          FormWithOutPrefix(
                            hintText: S.current.loan_to_vl,
                            typeForm: TypeFormWithoutPrefix.IMAGE,
                            cubit: '',
                            txtController: _txtLoanToVl,
                            imageAsset: ImageAssets.ic_percent,
                            isTokenOrQuantity: false,
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
                          FormWithOutPrefix(
                            hintText: S.current.enter_loan_amount,
                            typeForm: TypeFormWithoutPrefix.IMAGE_FT_TEXT,
                            cubit: '',
                            txtController: _txtLoanAmount,
                            imageAsset: ImageAssets.symbol,
                            nameToken: 'DFY',
                            isTokenOrQuantity: true,
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
                          FormWithOutPrefix(
                            hintText: S.current.enter_interest_rate,
                            typeForm: TypeFormWithoutPrefix.NONE,
                            cubit: '',
                            txtController: _txtInterestRate,
                            imageAsset: ImageAssets.symbol,
                            nameToken: 'DFY',
                            isTokenOrQuantity: false,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            S.current.ltv_liquid_thres,
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              14.sp,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH4,
                          FormWithOutPrefix(
                            hintText: S.current.ltv_liquid_thres,
                            typeForm: TypeFormWithoutPrefix.IMAGE,
                            cubit: '',
                            txtController: _txtLiquidationThr,
                            imageAsset: ImageAssets.ic_percent,
                            isTokenOrQuantity: false,
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
                          FormWithOutPrefix(
                            hintText: S.current.repayment_curr,
                            typeForm: TypeFormWithoutPrefix.IMAGE,
                            cubit: '',
                            txtController: _txtRepaymentCurrency,
                            imageAsset: ImageAssets.ic_drop_down,
                            isTokenOrQuantity: false,
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
                          FormWithOutPrefix(
                            hintText: S.current.recurring_interest,
                            typeForm: TypeFormWithoutPrefix.IMAGE,
                            cubit: '',
                            txtController: _txtRecurringInterest,
                            imageAsset: ImageAssets.ic_percent,
                            isTokenOrQuantity: false,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (_) {
                    //     return const ConfirmBlockchainCategory(
                    //       nameWallet: 'Test Wallet',
                    //       nameTokenWallet: 'BNB',
                    //       balanceWallet: 0.551,
                    //       typeConfirm: TYPE_CONFIRM.SEND_OFFER,
                    //       addressFrom: '0xFE5788e2...EB7144fd0',
                    //       addressTo: '0xf94138c9...43FE932eA',
                    //       imageWallet: ImageAssets.symbol,
                    //     );
                    //   },
                    // );
                  },
                  child: ButtonGold(
                    title: S.current.send_offer,
                    isEnable: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
