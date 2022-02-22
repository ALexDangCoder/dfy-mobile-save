import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_hard_nft/bloc/list_hard_nft_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'check_box_item.dart';

class FilterHardNFT extends StatefulWidget {
  final ListHardNftBloc bloc;

  const FilterHardNFT({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  _FilterHardNFTState createState() => _FilterHardNFTState();
}

class _FilterHardNFTState extends State<FilterHardNFT> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
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
                      widget.bloc.resetFilterNFTMyAcc();
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
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.status,
                    style: textNormalCustom(null, 16, FontWeight.w600),
                  ),
                  spaceH24,
                  Row(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<bool>>(
                          stream: bloc.listFilterStream,
                          builder: (context, snapshot) {
                            final listFilter = snapshot.data;
                            return CheckBoxItem(
                              isSelected:
                                  listFilter?[ListHardNftBloc.SALE_FILTER] ??
                                      false,
                              nameCkcFilter: S.current.on_sell,
                              bloc: bloc,
                              index: ListHardNftBloc.SALE_FILTER,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<List<bool>>(
                            stream: bloc.listFilterStream,
                            builder: (context, snapshot) {
                              final listFilter = snapshot.data;
                              return CheckBoxItem(
                                isSelected:
                                    listFilter?[ListHardNftBloc.PAWN_FILTER] ??
                                        false,
                                nameCkcFilter: S.current.on_pawn,
                                bloc: bloc,
                                index: ListHardNftBloc.PAWN_FILTER,
                              );
                            }),
                      ),
                    ],
                  ),
                  spaceH24,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: StreamBuilder<List<bool>>(
                            stream: bloc.listFilterStream,
                            builder: (context, snapshot) {
                              final listFilter = snapshot.data;
                              return CheckBoxItem(
                                isSelected: listFilter?[
                                        ListHardNftBloc.AUCTION_FILTER] ??
                                    false,
                                nameCkcFilter: S.current.on_auction,
                                bloc: bloc,
                                index: ListHardNftBloc.AUCTION_FILTER,
                              );
                            }),
                      ),
                      Expanded(
                        child: StreamBuilder<List<bool>>(
                            stream: bloc.listFilterStream,
                            builder: (context, snapshot) {
                              final listFilter = snapshot.data;
                              return CheckBoxItem(
                                isSelected: listFilter?[
                                        ListHardNftBloc.NOT_ON_MARKET_FILTER] ??
                                    false,
                                nameCkcFilter: S.current.not_on_market,
                                bloc: bloc,
                                index: ListHardNftBloc.NOT_ON_MARKET_FILTER,
                              );
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            spaceH24,
            GestureDetector(
              onTap: () {
                bloc.funFilterNft();
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
