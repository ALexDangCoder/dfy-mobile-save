import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/bloc/lender_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/loan_request_detail/ui/loan_request_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoanRequestCryptoItem extends StatelessWidget {
  const LoanRequestCryptoItem({
    Key? key,
    required this.cryptoModel,
    required this.cubit,
  }) : super(key: key);
  final LoanRequestCryptoModel cryptoModel;
  final LenderLoanRequestCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoanRequestDetail(
              typeDetail: TypeDetail.CRYPTO,
              id: cryptoModel.id.toString(),
              walletAddress: cryptoModel.collateralOwner?.walletAddress ?? '',
            ),
          ),
        );
      },
      child: Container(
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
              title: S.current.message.capitalize().withColon(),
              description: cryptoModel.message ?? '',
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.collateral.capitalize().withColon(),
              isLoanAmount: true,
              urlToken: cryptoModel.collateralSymbol,
              description: formatPrice.format(cryptoModel.collateralAmount),
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
                title: S.current.loan_currency.capitalize().withColon(),
                isLoanAmount: true,
                urlToken: cryptoModel.loanSymbol,
                description: ''
                // description: cryptoModel.loanSymbol ?? DFY,
                ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(
              title: S.current.duration,
              description: cubit.categoryOneOrMany(
                durationQty: cryptoModel.durationQty ?? 0,
                durationType: cryptoModel.durationType ?? 0,
              ),
            ),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(title: S.current.status, isStatus: true, description: ''),
            SizedBox(
              height: 17.w,
            ),
            _rowItem(title: 'From package:', description: cryptoModel.p2pLenderPackageModel?.name ?? ''),
          ],
        ),
      ),
    );
  }

  Row _rowItem({
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
            flex: 5,
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
            flex: 5,
            child: Text(
              cubit.getStatus(cryptoModel.status.toString()),
              style: textNormalCustom(
                cubit.getColor(
                  cryptoModel.status.toString(),
                ),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else
          Expanded(
            flex: 5,
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
