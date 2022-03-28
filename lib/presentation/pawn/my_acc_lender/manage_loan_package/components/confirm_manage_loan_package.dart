import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_CONFIRM_MNG_lOAN {
  CONFIRM_ACCEPT_COLLATERAL,
  CONFIRM_REJECT_COLLATERAL,
  CONFIRM_CANCEL_PACKAGE
}

class ConfirmManageLoanPackage extends StatelessWidget {
  const ConfirmManageLoanPackage({
    Key? key,
    required this.typeConfirmManageLoan,
  }) : super(key: key);
  final TYPE_CONFIRM_MNG_lOAN typeConfirmManageLoan;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: Container(
        padding: EdgeInsets.only(
          bottom: 38.h,
        ),
        color: AppTheme.getInstance().bgBtsColor(),
        child: GestureDetector(
          onTap: null,
          child: ButtonGold(
            isEnable: true,
            title: getTitleButton(),
          ),
        ),
      ),
      title: getTitleConfirm(),
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            spaceH22,
            Text(
              getDescriptionConfirm(),
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

  String getDescriptionConfirm() {
    String result = '';
    switch (typeConfirmManageLoan) {
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_ACCEPT_COLLATERAL:
        result = S.current.description_confirm_accept_manage_loan;
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_CANCEL_PACKAGE:
        result = S.current.description_confirm_cancel_manage_loan;
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_REJECT_COLLATERAL:
        result = S.current.description_confirm_reject_manage_loan;
        break;
      default:
        result = '';
        break;
    }
    return result;
  }

  String getTitleConfirm() {
    String result = '';
    switch (typeConfirmManageLoan) {
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_ACCEPT_COLLATERAL:
        result = S.current.confirm_accept_collateral;
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_CANCEL_PACKAGE:
        result = S.current.confirm_reject_collateral;
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_REJECT_COLLATERAL:
        result = S.current.confirm_cancel_cancel_package;
        break;
      default:
        result = '';
        break;
    }
    return result;
  }

  String getTitleButton() {
    String result = '';
    switch (typeConfirmManageLoan) {
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_ACCEPT_COLLATERAL:
        result = S.current.accept.capitalize();
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_CANCEL_PACKAGE:
        result = S.current.reject.capitalize();
        break;
      case TYPE_CONFIRM_MNG_lOAN.CONFIRM_REJECT_COLLATERAL:
        result = S.current.confirm_cancel_cancel_package;
        break;
      default:
        result = '';
        break;
    }
    return result;
  }
}
