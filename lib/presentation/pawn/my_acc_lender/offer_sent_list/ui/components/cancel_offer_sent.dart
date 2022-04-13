import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/lend_contract_detail.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class CancelOfferSent extends StatelessWidget {
  const CancelOfferSent({
    Key? key,
    required this.model,
    required this.cubit,
  }) : super(key: key);
  final OfferSentListCubit cubit;
  final OfferSentDetailCryptoModel model;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      bottomBar: _btnConfirm(context),
      title: S.current.confirm_cancel_offer,
      child: Container(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceH24,
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    S.current.loan_amount,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteWithOpacitySevenZero(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.network(ImageAssets.getUrlToken(
                              model.supplyCurrencySymbol ?? 'DFY'))),
                      spaceW8,
                      Text(
                        formatPrice.format(
                          model.loanAmount,
                        ),
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            spaceH32,
            Text(
              S.current.description_cancel_offer_sent,
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

  Widget _btnConfirm(BuildContext ctx) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        color: AppTheme.getInstance().bgBtsColor(),
        padding: EdgeInsets.only(
          bottom: 38.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            gradient: RadialGradient(
              center: const Alignment(0.5, -0.5),
              radius: 4,
              colors: AppTheme.getInstance().gradientButtonColor(),
            ),
            border: Border.all(color: AppTheme.getInstance().fillColor()),
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                S.current.cancel_offer,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20,
                  FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
