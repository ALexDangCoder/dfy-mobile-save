import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemRepayment extends StatelessWidget {
  const ItemRepayment({
    Key? key,
    required this.obj,
    required this.index,
    required this.bloc,
  }) : super(key: key);
  final RepaymentRequestModel obj;
  final int index;
  final ContractDetailBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        bottom: 20.h,
        right: 16.w,
        left: 16.w,
        top: 20.h,
      ),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.cycle}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  index.toString(),
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.due_date}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  0.formatDateTimeMy(obj.dueDate ?? 0),
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.penalty}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: textNormalCustom(
                      AppTheme.getInstance().getGray3(),
                      16.sp,
                      FontWeight.w400,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.network(
                          ImageAssets.getSymbolAsset(
                            obj.penalty?.symbol.toString() ?? '',
                          ),
                          width: 16.sp,
                          height: 16.sp,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) =>
                              Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                            width: 16.sp,
                            height: 16.sp,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: SizedBox(
                          width: 4.w,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          '${formatPrice.format(obj.penalty?.amountPaid ?? 0)}'
                          '/${formatPrice.format(obj.penalty?.amount ?? 0)}',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.interest}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: textNormalCustom(
                      AppTheme.getInstance().getGray3(),
                      16.sp,
                      FontWeight.w400,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.network(
                          ImageAssets.getSymbolAsset(
                            obj.interest?.symbol.toString() ?? '',
                          ),
                          width: 16.sp,
                          height: 16.sp,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) =>
                              Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                            width: 16.sp,
                            height: 16.sp,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: SizedBox(
                          width: 4.w,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          '${formatPrice.format(obj.interest?.amountPaid ?? 0)}'
                          '/${formatPrice.format(obj.interest?.amount ?? 0)}',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.loan}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: textNormalCustom(
                      AppTheme.getInstance().getGray3(),
                      16.sp,
                      FontWeight.w400,
                    ),
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.network(
                          ImageAssets.getSymbolAsset(
                            obj.loan?.symbol.toString() ?? '',
                          ),
                          width: 16.sp,
                          height: 16.sp,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) =>
                              Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                            width: 16.sp,
                            height: 16.sp,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: SizedBox(
                          width: 4.w,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          '${formatPrice.format(obj.loan?.amountPaid ?? 0)}'
                          '/${formatPrice.format(obj.loan?.amount ?? 0)}',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  '${S.current.status}:',
                  style: textNormalCustom(
                    AppTheme.getInstance().gray3Color(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  bloc.getStatusHistory(obj.status ?? 0),
                  style: textNormalCustom(
                    bloc.getColorHistory(obj.status ?? 0),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
