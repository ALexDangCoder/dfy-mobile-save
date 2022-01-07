import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterActivity extends StatefulWidget {
  final DetailCollectionBloc collectionBloc;

  const FilterActivity({
    Key? key,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  _FilterActivityState createState() => _FilterActivityState();
}

class _FilterActivityState extends State<FilterActivity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final collectionBloc = widget.collectionBloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 9.h,
            ),
            SizedBox(
              height: 5.h,
              child: Center(
                child: Image.asset(
                  ImageAssets.imgRectangle,
                ),
              ),
            ),
            spaceH20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    child: Text(
                      S.current.reset,
                      style: textNormalCustom(
                        AppTheme.getInstance().bgBtsColor(),
                        14,
                        null,
                      ),
                    ),
                  ),
                  Text(
                    S.current.filter,
                    style: textNormalCustom(
                      null,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.collectionBloc.resetFilterActivity(false);
                      },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().colorTextReset(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        S.current.reset,
                        style: textNormalCustom(
                          null,
                          14,
                          null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            spaceH24,
            Container(
              padding: EdgeInsets.only(
                left: 6.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.transfer,
                          stream: collectionBloc.isTransfer,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.put_on_market,
                          stream: collectionBloc.isPutOnMarket,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.cancel,
                          stream: collectionBloc.isCancelMarket,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.buy,
                          stream: collectionBloc.isBuy,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.bid_buy_out,
                          stream: collectionBloc.isBid,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.receive_offer,
                          stream: collectionBloc.isReceiveOffer,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.sign_contract,
                          stream: collectionBloc.isSignContract,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.burn,
                          stream: collectionBloc.isBurn,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.like,
                          stream: collectionBloc.isLike,
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.report,
                          stream: collectionBloc.isReport,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spaceH24,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ButtonLuxury(
                title: S.current.apply,
                isEnable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
