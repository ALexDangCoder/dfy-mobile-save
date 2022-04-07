import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollateralMyAcc extends StatelessWidget {
  const ItemCollateralMyAcc({
    Key? key,
    required this.bloc,
    required this.index,
  }) : super(key: key);
  final CollateralMyAccBloc bloc;
  final int index;

  @override
  Widget build(BuildContext context) {
    final obj = bloc.list[index];
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
                      '${S.current.message}:',
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
                      obj.description.toString(),
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
                      '${S.current.collateral}:',
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
                                obj.collateralSymbol.toString(),
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
                              '${formatPrice.format(obj.collateralAmount)} ${obj.collateralSymbol.toString()}',
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
                                obj.loanSymbol.toString(),
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
                              obj.loanSymbol.toString(),
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
                      '${S.current.duration}',
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
                      '${obj.durationQty} ${obj.durationType == WEEK ? S.current.week : S.current.month}',
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
                      '${S.current.offer_received}:',
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
                      obj.numberOfferReceived.toString(),
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
                      getStatus(obj.status ?? 0),
                      style: textNormalCustom(
                        getColor(obj.status ?? 0),
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

  String getStatus(int status) {
    switch (status) {
      case CollateralMyAccBloc.PROCESSING_CREATE:
        return S.current.processing_create;
      case CollateralMyAccBloc.FAIL_CREATE:
        return S.current.failed_create;
      case CollateralMyAccBloc.OPEN:
        return S.current.open;
      case CollateralMyAccBloc.PROCESSING_ACCEPT:
        return S.current.processing_accept;
      case CollateralMyAccBloc.PROCESSING_WITHDRAW:
        return S.current.processing_withdraw;
      case CollateralMyAccBloc.ACCEPTED:
        return S.current.accepted;
      case CollateralMyAccBloc.WITHDRAW:
        return S.current.withdraw;
      case CollateralMyAccBloc.FAILED:
        return S.current.failed;
      default:
        return '';
    }
  }

  Color getColor(int status) {
    switch (status) {
      case CollateralMyAccBloc.PROCESSING_CREATE:
        return AppTheme.getInstance().orangeMarketColors();
      case CollateralMyAccBloc.FAIL_CREATE:
        return AppTheme.getInstance().redColor();
      case CollateralMyAccBloc.OPEN:
        return AppTheme.getInstance().blueColor();
      case CollateralMyAccBloc.PROCESSING_ACCEPT:
        return AppTheme.getInstance().orangeMarketColors();
      case CollateralMyAccBloc.PROCESSING_WITHDRAW:
        return AppTheme.getInstance().orangeMarketColors();
      case CollateralMyAccBloc.ACCEPTED:
        return AppTheme.getInstance().greenMarketColors();
      case CollateralMyAccBloc.WITHDRAW:
        return AppTheme.getInstance().redColor();
      case CollateralMyAccBloc.FAILED:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }
}
