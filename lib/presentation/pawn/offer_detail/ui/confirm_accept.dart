import 'dart:async';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/bloc/offer_detail_my_acc_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmAccept extends StatefulWidget {
  const ConfirmAccept({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final OfferDetailMyAccBloc bloc;

  @override
  _ConfirmAcceptState createState() => _ConfirmAcceptState();
}

class _ConfirmAcceptState extends State<ConfirmAccept> {
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
                          S.current.confirm_accept_offer,
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
                    child: Text(
                      S.current.by_accept_offer,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
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
                  await widget.bloc.getAcceptCryptoOfferData(
                    bcOfferId: widget.bloc.obj?.bcOfferId.toString() ?? '',
                    bcCollateralId:
                        widget.bloc.obj?.bcCollateralId.toString() ?? '',
                  );
                  unawaited(
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => Approve(
                          textActiveButton: S.current.confirm_accept_offer,
                          spender:
                              Get.find<AppConstants>().crypto_pawn_contract,
                          hexString: widget.bloc.hexStringAccept,
                          tokenAddress: Get.find<AppConstants>().contract_defy,
                          title: S.current.confirm_send_offer,
                          listDetail: [],
                          onErrorSign: (context) {},
                          onSuccessSign: (context, data) {
                            widget.bloc.putAcceptOffer();
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
                    title: S.current.accepted,
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
