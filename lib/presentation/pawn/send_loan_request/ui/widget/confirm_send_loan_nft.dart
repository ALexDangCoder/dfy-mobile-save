import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmSendLoanNft extends StatelessWidget {
  const ConfirmSendLoanNft({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SendLoanRequestCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Confirm loan request',
      onRightClick: () {},
      text: ImageAssets.ic_close,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                spaceH24,
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  child: Text(
                    'Collateral:',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteWithOpacitySevenZero(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceH16,
                //todo widget Nft
                spaceH20,
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Message:',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteWithOpacitySevenZero(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH20,
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loan amount:',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteWithOpacitySevenZero(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH20,
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration:',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteWithOpacitySevenZero(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 38.h),
            color: AppTheme.getInstance().bgBtsColor(),
            child: GestureDetector(
              onTap: () {},
              child: const ButtonGold(
                title: 'Request Loan',
                isEnable: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
