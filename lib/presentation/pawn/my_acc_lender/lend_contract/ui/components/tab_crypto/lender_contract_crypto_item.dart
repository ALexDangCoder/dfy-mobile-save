import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/bloc/lender_contract_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatPrice = NumberFormat('###,###,###.###', 'en_US');

class LenderContractCryptoItem extends StatelessWidget {
  const LenderContractCryptoItem({
    Key? key,
    required this.obj,
    required this.cubit,
  }) : super(key: key);
  final CryptoPawnModel obj;
  final LenderContractCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        bottom: 20.h,
        right: 16.w,
      ),
      margin: EdgeInsets.only(
        bottom: 20.h,
        left: 16.w,
        right: 16.w,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _rowItem(
            title: S.current.collateral.capitalize().withColon(),
            isLoanAmount: true,
            urlToken: obj.collateral.toString(),
            description: formatPrice.format(obj.collateralAmount),
          ),
          SizedBox(
            height: 17.w,
          ),
          _rowItem(
            title: S.current.loan_amount.capitalize().withColon(),
            isLoanAmount: true,
            urlToken: obj.supplyCurrency.toString(),
            description: formatPrice.format(obj.supplyCurrencyAmount),
          ),
          SizedBox(
            height: 17.w,
          ),
          _rowItem(
            title: S.current.interest_rate_apr.capitalize().withColon(),
            description: '${obj.interestPerYear.toString()} %',
          ),
          SizedBox(
            height: 17.w,
          ),
          _rowItem(
            title: S.current.duration,
            description: cubit.categoryOneOrMany(
              durationQty: obj.duration ?? 0,
              durationType: obj.durationType ?? 0,
            ),
          ),
          SizedBox(
            height: 17.w,
          ),
          _rowItem(title: S.current.status, isStatus: true, description: ''),
        ],
      ),
    );
  }

  Row _rowItem({
    int? status,
    String? urlToken,
    required String title,
    bool isLoanAmount = false,
    bool isStatus = false,
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        if (isLoanAmount)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child:
                      Image.network(ImageAssets.getUrlToken(urlToken ?? DFY)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '$description $urlToken',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        else if (isStatus)
          Expanded(
            flex: 6,
            child: Text(
              cubit.getStatus(obj.status.toString()),
              style: textNormalCustom(
                cubit.getColor(
                  obj.status.toString(),
                ),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else
          Expanded(
            flex: 6,
            child: Text(
              description,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }
}
