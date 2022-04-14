import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/loan_request_detail/bloc/loan_request_detail_cubit.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmRejectLoanRequest extends StatelessWidget {
  const ConfirmRejectLoanRequest({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final LoanRequestDetailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: InkWell(
        onTap: () async {
          // cubit.rejectOfferCryptoLoanRequest(id: ) todo
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
