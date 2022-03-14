import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/personal_lending_hard/bloc/personal_lending_hard_bloc.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/send_loan_requet.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalItem extends StatelessWidget {
  final String nameShop;
  final bool isShop;
  final String rate;
  final int collateral;
  final String interestRate;
  final String signedContract;
  final String total;

  const PersonalItem({
    Key? key,
    required this.nameShop,
    required this.isShop,
    required this.rate,
    required this.collateral,
    required this.interestRate,
    required this.signedContract,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 343.w,
        padding: EdgeInsets.only(
          left: 16.w,
          bottom: 24.h,
          right: 16.w,
          top: 16.h,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: RichText(
                    text: TextSpan(
                      text: nameShop,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w600,
                      ).copyWith(
                        overflow: TextOverflow.clip,
                      ),
                      children: [
                        WidgetSpan(
                          child: spaceW6,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: isShop
                              ? Image.asset(ImageAssets.ic_selected)
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
                spaceH12,
                Expanded(
                  flex: 2,
                  child: RichText(
                    maxLines: 1,
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: '',
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w600,
                      ).copyWith(
                        overflow: TextOverflow.clip,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(ImageAssets.img_star),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: spaceW6,
                        ),
                        TextSpan(text: rate),
                      ],
                    ),
                  ),
                )
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.interest_rate_apr}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceW4,
                Expanded(
                  child: Text(
                    interestRate,
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${S.current.collateral_accepted}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceW4,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: textNormalCustom(
                        null,
                        14,
                        FontWeight.w400,
                      ),
                      children: [
                        WidgetSpan(
                          child: collateral == PersonalLendingHardBloc.ALL
                              ? const SizedBox.shrink()
                              : Image.asset(
                                  ImageAssets.ic_hard,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                        ),
                        WidgetSpan(
                          child: collateral == PersonalLendingHardBloc.ALL
                              ? const SizedBox.shrink()
                              : spaceW4,
                        ),
                        TextSpan(
                          text: checkText(collateral),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.sign_contract_pawn}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceW4,
                Expanded(
                  child: Text(
                    formatPrice.format(double.parse(signedContract)),
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            line,
            spaceH12,
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: '\$ ${formatPrice.format(double.parse(total))}  ',
                  style: textNormalCustom(
                    null,
                    24,
                    FontWeight.w600,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => InfoPopup(
                              name: S.current.total_contract_value,
                              content: S.current.total_value_of_all,
                            ),
                          );
                        },
                        child: Image.asset(
                          ImageAssets.img_waning,
                          height: 20.w,
                          width: 20.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            spaceH24,
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SendLoanRequest();
                      },
                    ),
                  );
                },
                child: SizedBox(
                  width: 140.w,
                  height: 40.h,
                  child: ButtonGold(
                    radiusButton: 16,
                    haveMargin: false,
                    title: S.current.request_loan,
                    isEnable: true,
                    fixSize: false,
                    textSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String checkText(int type) {
    switch (type) {
      case PersonalLendingHardBloc.ALL:
        return S.current.all_type_of_NFT;
      case PersonalLendingHardBloc.HARD:
        return S.current.hard_NFT;
      case PersonalLendingHardBloc.SORT:
        return S.current.soft_nft;
      default:
        return '';
    }
  }
}
