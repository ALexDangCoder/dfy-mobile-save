import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/send_offfer/confirm_reject_loan_request.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/cool_drop_down/cool_drop_down.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanSendOffer extends StatefulWidget {
  const LoanSendOffer({Key? key, required this.isCryptoElseNft})
      : super(key: key);
  final bool isCryptoElseNft;

  @override
  _LoanSendOfferState createState() => _LoanSendOfferState();
}

class _LoanSendOfferState extends State<LoanSendOffer> {
  LenderLoanRequestCubit cubit = LenderLoanRequestCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ConfirmRejectLoanRequest())),
        child: Container(
          color: AppTheme.getInstance().bgBtsColor(),
          padding: EdgeInsets.only(bottom: 38.h),
          child: ButtonGold(
            isEnable: true,
            title: S.current.send_offer,
          ),
        ),
      ),
      title: S.current.send_offer.capitalize(),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH24,
              _textTitle(title: S.current.message),
              TextFieldValidator(
                hint: S.current.enter_mess,
              ),
              spaceH16,
              _textTitle(title: S.current.loan_to_value, isHaveIcWarning: true),
              TextFieldValidator(
                hint: S.current.enter_mess,
                suffixIcon: IconButton(
                  icon: Text(
                    '%',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              spaceH16,
              _textTitle(title: S.current.loan_amount.removeColon()),
              TextFieldValidator(
                hint: S.current.enter_mess,
                suffixIcon: SizedBox(
                  width: 70.w,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.network(ImageAssets.getUrlToken('DFY')),
                      ),
                      spaceW3,
                      Text(
                        'DFY',
                        style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              spaceH16,
              _textTitle(title: S.current.interest_rate.removeColon()),
              TextFieldValidator(
                suffixIconConstraint: BoxConstraints(
                  maxHeight: 100.h,
                  maxWidth: 100.w,
                ),
                hint: S.current.enter_interest_rate,
              ),
              spaceH16,
              _textTitle(
                  title: S.current.ltv_liquid_thres, isHaveIcWarning: true),
              TextFieldValidator(
                hint: S.current.enter_liquidation_threshold,
                suffixIcon: IconButton(
                  icon: Text(
                    '%',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              ///Form duration
              spaceH16,
              _textTitle(
                title: S.current.duration,
              ),
              TextFieldValidator(
                hint: S.current.enter_duration,
                suffixIcon: SizedBox(
                  width: 100.w,
                  child: _dropDown(
                      listDropDown: cubit.durationList, onChange: (value) {}),
                ),
              ),

              ///Form repaymentToken
              spaceH16,
              _textTitle(
                title: S.current.repayment_token,
              ),
              TextFieldValidator(
                suffixIcon: _dropDown(
                    isMonth: false,
                    listDropDown: cubit.durationList,
                    onChange: (value) {}),
              ),
              spaceH16,
              _textTitle(title: S.current.recurring_interest,),
              TextFieldValidator(
                hint: S.current.recurring_interest,
                suffixIcon: IconButton(
                  icon: Text(
                    '%',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              spaceH46,
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropDown({
    required List<Map<String, dynamic>> listDropDown,
    required Function(Map<String, dynamic> value) onChange,
    bool? isMonth = true,
  }) {
    return Stack(
      children: [
        CoolDropdown(
          // gap: 8.h,
          dropdownItemMainAxis: MainAxisAlignment.end,
          resultMainAxis: MainAxisAlignment.start,
          dropdownList: listDropDown,
          onChange: (value) {
            onChange(value);
          },
          dropdownItemHeight: 54.h,
          dropdownHeight: 130.h,
          dropdownWidth: (isMonth ?? true) ? 100.w : 343.w,
          resultAlign: Alignment.centerRight,
          resultWidth: 343.w,
          resultHeight: 64.h,
          dropdownPadding: EdgeInsets.only(right: 11.w),
          dropdownBD: BoxDecoration(
            color: AppTheme.getInstance().selectDialogColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultBD: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholder: S.current.select_condition,
          resultIcon: const SizedBox.shrink(),
          selectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          unselectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholderTS: textNormal(
            Colors.white.withOpacity(0.5),
            16,
          ),
          isTriangle: false,
          selectedItemBD: BoxDecoration(
            color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
          ),
        ),
        Positioned(
          right: 19.w,
          child: SizedBox(
            height: 64.h,
            child: sizedSvgImage(
              w: 13,
              h: 13,
              image: ImageAssets.ic_expand_white_svg,
            ),
          ),
        )
      ],
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
