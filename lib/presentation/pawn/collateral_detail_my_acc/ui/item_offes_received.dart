import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/offers_received_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemOfferReceived extends StatelessWidget {
  const ItemOfferReceived({
    Key? key,
    required this.obj,
    required this.bloc,
  }) : super(key: key);
  final OffersReceivedModel obj;
  final CollateralDetailMyAccBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 343.w,
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
        child: Container(
          margin: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
            top: 18.h,
            bottom: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.lender}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      (obj.lender?.length ?? 0) > 20
                          ? obj.lender.toString().formatAddressWalletConfirm()
                          : obj.lender.toString(),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.loan_token}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: '',
                        style: textNormal(
                          null,
                          16,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Image.network(
                              ImageAssets.getSymbolAsset(
                                obj.supplyCurrency?.symbol ?? '',
                              ),
                              width: 16.sp,
                              height: 16.sp,
                              errorBuilder: (context, error, stackTrace) =>
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
                              '${formatPrice.format(obj.supplyCurrency?.amount)}'
                              ' ${obj.supplyCurrency?.symbol ?? ''}',
                              style: textNormal(
                                null,
                                16,
                              ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.duration}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${obj.duration} ${obj.durationType == WEEK ? S.current.weeks_pawn : S.current.months_pawn}',
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.interest_rate_pawn}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      '${obj.interestPerYear}%',
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      '${S.current.status}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().pawnItemGray(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  spaceW4,
                  Expanded(
                    flex: 6,
                    child: Text(
                      bloc.getStatusOffer(obj.status ?? 0),
                      style: textNormalCustom(
                        bloc.getColorOffer(obj.status ?? 0),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
