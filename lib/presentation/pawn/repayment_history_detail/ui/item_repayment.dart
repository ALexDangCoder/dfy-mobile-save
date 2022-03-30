import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/presentation/pawn/repayment_history_detail/bloc/repayment_history_detail_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemRepaymentHistory extends StatelessWidget {
  final RepaymentRequestModel obj;
  final RepaymentHistoryDetailBloc bloc;

  const ItemRepaymentHistory({
    Key? key,
    required this.obj,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        top: 16.h,
        bottom: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          richText(
            title: '${S.current.repayment_date}:',
            value: 0.formatDateTimeMy(obj.paymentDate ?? 0),
          ),
          spaceH16,
          richText(
            title: '${S.current.txn_hash}:',
            value: obj.txnHash.toString().formatAddressActivityFire(),
          ),
          spaceH16,
          richText(
            title: '${S.current.penalty}:',
            value: '${formatPrice.format(
              obj.penalty?.amountPaid ?? 0,
            )}/${formatPrice.format(
              obj.penalty?.amount ?? 0,
            )} ${obj.penalty?.symbol ?? ''}',
            isIcon: true,
            url: ImageAssets.getUrlToken(obj.penalty?.symbol ?? ''),
          ),
          spaceH16,
          richText(
            title: '${S.current.interest}:',
            value: '${formatPrice.format(
              obj.interest?.amountPaid ?? 0,
            )}/${formatPrice.format(
              obj.interest?.amount ?? 0,
            )} ${obj.interest?.symbol ?? ''}',
            isIcon: true,
            url: ImageAssets.getUrlToken(obj.interest?.symbol ?? ''),
          ),
          spaceH16,
          richText(
            title: '${S.current.loan}:',
            value: '${formatPrice.format(
              obj.loan?.amountPaid ?? 0,
            )}/${formatPrice.format(
              obj.loan?.amount ?? 0,
            )} ${obj.loan?.symbol ?? ''}',
            isIcon: true,
            url: ImageAssets.getUrlToken(obj.loan?.symbol ?? ''),
          ),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: bloc.getStatusHistory(obj.status ?? 0),
            myColor: bloc.getColorHistory(obj.status ?? 0),
          ),
        ],
      ),
    );
  }
}
