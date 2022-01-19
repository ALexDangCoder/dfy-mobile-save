import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'check_box_select_one.dart';

class FilterNFTMyAcc extends StatefulWidget {
  final DetailCollectionBloc collectionBloc;
  final PageRouter typeScreen;

  const FilterNFTMyAcc({
    Key? key,
    required this.collectionBloc,
    required this.typeScreen,
  }) : super(key: key);

  @override
  _FilterNFTMyAccState createState() => _FilterNFTMyAccState();
}

class _FilterNFTMyAccState extends State<FilterNFTMyAcc> {
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
                      widget.collectionBloc.resetFilterNFTMyAcc();
                    },
                    child: Container(
                      height: 30.h,
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
                  )
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
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      S.current.view_type,
                      style: textNormalCustom(null, 16, FontWeight.w600),
                    ),
                  ),
                  StreamBuilder<List<bool>>(
                      stream: collectionBloc.listViewTypeFilterNftStream,
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            Expanded(
                              child: IsCheckBoxSelectOne(
                                title: S.current.all,
                                index: DetailCollectionBloc.ALL,
                                bloc: collectionBloc,
                              ),
                            ),
                            Expanded(
                              child: IsCheckBoxSelectOne(
                                title: S.current.owner,
                                bloc: collectionBloc,
                                index: DetailCollectionBloc.OWNER,
                              ),
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      S.current.status,
                      style: textNormalCustom(null, 16, FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.on_sell,
                          stream: collectionBloc.isOnSale,
                          funCheckBox: () => collectionBloc.listFilter.clear(),
                          funText: () => collectionBloc.listFilter.clear(),
                        ),
                      ),
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.on_pawn,
                          stream: collectionBloc.isOnPawn,
                          funCheckBox: () => collectionBloc.listFilter.clear(),
                          funText: () => collectionBloc.listFilter.clear(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: IsBaseCheckBox(
                          title: S.current.on_auction,
                          stream: collectionBloc.isOnAuction,
                          funCheckBox: () => collectionBloc.listFilter.clear(),
                          funText: () => collectionBloc.listFilter.clear(),
                        ),
                      ),
                      Expanded(
                        child: widget.typeScreen == PageRouter.MY_ACC
                            ? IsBaseCheckBox(
                                title: S.current.not_on_market,
                                stream: collectionBloc.isNotOnMarket,
                                funCheckBox: () =>
                                    collectionBloc.listFilter.clear(),
                                funText: () =>
                                    collectionBloc.listFilter.clear(),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spaceH24,
            GestureDetector(
              onTap: () {
                collectionBloc.funFilterNft();
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
