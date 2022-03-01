import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/bloc/pawn_list_bloc.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/widget_filter.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPawn extends StatefulWidget {
  final PawnListBloc bloc;

  const FilterPawn({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  State<FilterPawn> createState() => _FilterPawnState();
}

class _FilterPawnState extends State<FilterPawn> {
  late TextEditingController textSearch;

  @override
  void initState() {
    super.initState();
    textSearch = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      //todo reset
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
                  )
                ],
              ),
            ),
            spaceH24,
            FormSearchBase(
              onChangedFunction: () {},
              onTapFunction: () {},
              urlIcon: ImageAssets.ic_search,
              hint: S.current.pawn,
              textSearchStream: widget.bloc.textSearch,
              textSearch: textSearch,
            ),
            spaceH16,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Text(
                S.current.interest_range,
                style: textNormalCustom(
                  null,
                  16,
                  FontWeight.w600,
                ),
              ),
            ),
            spaceH16,
            //todo body
            spaceH16,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Text(
                S.current.collateral_accepted,
                style: textNormalCustom(
                  null,
                  16,
                  FontWeight.w600,
                ),
              ),
            ),
            spaceH16,
            //todo body
            ItemWidgetFilter(),
            spaceH16,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Text(
                S.current.loan_currency,
                style: textNormalCustom(
                  null,
                  16,
                  FontWeight.w600,
                ),
              ),
            ),
            spaceH16,
            ItemWidgetFilter(),
            //todo body
            spaceH40,
            GestureDetector(
              onTap: () {
                //todo filter
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
