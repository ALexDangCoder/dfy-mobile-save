import 'dart:async';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmWithDrawCollateral extends StatelessWidget {
  const ConfirmWithDrawCollateral({
    Key? key,
    required this.bloc,
    required this.obj,
  }) : super(key: key);
  final CollateralDetailMyAccBloc bloc;
  final CollateralDetailMyAcc obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Container(
              height: 812.h,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.h),
                  topRight: Radius.circular(30.h),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w),
                          width: 24.w,
                          height: 24.h,
                          child: Image.asset(ImageAssets.ic_back),
                        ),
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          S.current.confirm_withdraw_collateral,
                          style: textNormalCustom(
                            null,
                            20.sp,
                            FontWeight.w700,
                          ).copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 16.w,
                        ),
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                  spaceH20,
                  line,
                  spaceH20,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                '${S.current.your_collateral}:',
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
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) =>
                                            Container(
                                          color: AppTheme.getInstance()
                                              .bgBtsColor(),
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
                                        '${formatPrice.format(
                                          obj.collateralAmount ?? 0,
                                        )}'
                                        ' ${obj.collateralSymbol.toString().toUpperCase()}',
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
                        spaceH35,
                        Text(
                          S.current.your_collateral_will,
                          style: textNormalCustom(null, 16, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  final NavigatorState navigator = Navigator.of(context);
                  await bloc.getWithdrawCryptoCollateralData(
                    wad: obj.bcCollateralId.toString(),
                  );
                  unawaited(
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => Approve(
                          textActiveButton: S.current.withdraw,
                          spender:
                              Get.find<AppConstants>().crypto_pawn_contract,
                          hexString: bloc.hexString,
                          tokenAddress: Get.find<AppConstants>().contract_defy,
                          title: S.current.confirm_withdraw_collateral,
                          listDetail: [
                            DetailItemApproveModel(
                              title: '${S.current.your_collateral}: ',
                              value: '${formatPrice.format(
                                obj.collateralAmount ?? 0,
                              )}'
                                  ' ${obj.collateralSymbol.toString().toUpperCase()}',
                              urlToken: ImageAssets.getSymbolAsset(
                                obj.collateralSymbol.toString(),
                              ),
                            ),
                          ],
                          onErrorSign: (context) {},
                          onSuccessSign: (context, data) {
                            bloc.postCollateralWithdraw(
                              id: obj.id.toString(),
                            );
                            showLoadSuccess(context).then((value) {
                              Navigator.of(context).popUntil((route) {
                                return route.settings.name ==
                                    AppRouter.collateral_detail_myacc;
                              });
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  color: AppTheme.getInstance().bgBtsColor(),
                  padding: EdgeInsets.only(
                    bottom: 38.h,
                  ),
                  child: ButtonGold(
                    isEnable: true,
                    title: S.current.withdraw,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
