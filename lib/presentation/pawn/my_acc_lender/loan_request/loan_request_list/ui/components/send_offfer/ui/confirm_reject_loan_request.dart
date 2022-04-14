import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/loan_request_detail/bloc/loan_request_detail_cubit.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmRejectLoanRequest extends StatelessWidget {
  const ConfirmRejectLoanRequest({
    Key? key,
    required this.cubit,
    required this.id,
    this.isCrypto = true,
  }) : super(key: key);
  final LoanRequestDetailCubit cubit;
  final String id;
  final bool? isCrypto;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: InkWell(
        onTap: () async {
          final navigator = Navigator.of(context);
          unawaited(showLoadingDialog(context));
          if(isCrypto ?? true) {
            await cubit.rejectOfferCryptoLoanRequest(id: id);
          } else {
            await cubit.rejectOfferNFTLoanRequest(id: id);
          }
          await showLoadSuccess(context)
              .then(
                (value) =>
                navigator.popUntil(
                      (route) =>
                  route.settings.name == AppRouter.loan_request_lender,
                ),
          );
        },
        child: Container(
          color: AppTheme.getInstance().bgBtsColor(),
          padding: EdgeInsets.only(bottom: 38.h),
          child: ButtonGold(
            isEnable: true,
            title: S.current.reject.capitalize(),
          ),
        ),
      ),
      title: S.current.confirm_reject_loan_request,
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.confirm_reject_loan_descrip,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
