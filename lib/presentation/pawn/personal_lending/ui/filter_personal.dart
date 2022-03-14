import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_bloc.dart';
import 'package:Dfy/presentation/pawn/personal_lending/ui/item_widget_filter.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'check_box_item.dart';

class PersonalFilter extends StatefulWidget {
  const PersonalFilter({Key? key, required this.bloc}) : super(key: key);
  final PersonalLendingBloc bloc;

  @override
  _PersonalFilterState createState() => _PersonalFilterState();
}

class _PersonalFilterState extends State<PersonalFilter> {
  late TextEditingController textSearch;

  @override
  void initState() {
    super.initState();
    textSearch = TextEditingController();
    widget.bloc.statusFilterFirst();
    textSearch.text = widget.bloc.searchStatus ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: SingleChildScrollView(
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
                          textSearch.text = '';
                          widget.bloc.funReset();
                          final FocusScopeNode currentFocus =
                              FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() {});
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
                  onChangedFunction: widget.bloc.funOnSearch,
                  onTapFunction: widget.bloc.funOnTapSearch,
                  urlIcon: ImageAssets.ic_search,
                  hint: S.current.search_personal_lender,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: StreamBuilder<List<bool>>(
                          stream: widget.bloc.listFilterStream,
                          builder: (context, snapshot) {
                            final listFilter = snapshot.data;
                            return CheckBoxItem(
                              isSelected: listFilter?[
                                      PersonalLendingBloc.ZERO_TO_TEN] ??
                                  false,
                              nameCkcFilter: S.current.zero_to_ten,
                              bloc: widget.bloc,
                              index: PersonalLendingBloc.ZERO_TO_TEN,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 14,
                        child: StreamBuilder<List<bool>>(
                          stream: widget.bloc.listFilterStream,
                          builder: (context, snapshot) {
                            final listFilter = snapshot.data;
                            return CheckBoxItem(
                              isSelected: listFilter?[
                                      PersonalLendingBloc.TEN_TO_TWENTY_FIVE] ??
                                  false,
                              nameCkcFilter: S.current.ten_twenty,
                              bloc: widget.bloc,
                              index: PersonalLendingBloc.TEN_TO_TWENTY_FIVE,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH16,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 15,
                        child: StreamBuilder<List<bool>>(
                          stream: widget.bloc.listFilterStream,
                          builder: (context, snapshot) {
                            final listFilter = snapshot.data;
                            return CheckBoxItem(
                              isSelected: listFilter?[PersonalLendingBloc
                                      .TWENTY_FIVE_TO_FIVETY] ??
                                  false,
                              nameCkcFilter: S.current.twenty_five,
                              bloc: widget.bloc,
                              index: PersonalLendingBloc.TWENTY_FIVE_TO_FIVETY,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 14,
                        child: StreamBuilder<List<bool>>(
                          stream: widget.bloc.listFilterStream,
                          builder: (context, snapshot) {
                            final listFilter = snapshot.data;
                            return CheckBoxItem(
                              isSelected: listFilter?[
                                      PersonalLendingBloc.MORE_THAN_FIVETY] ??
                                  false,
                              nameCkcFilter: S.current.more_than_fifty,
                              bloc: widget.bloc,
                              index: PersonalLendingBloc.MORE_THAN_FIVETY,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: ItemWidgetFilter(
                    bloc: widget.bloc,
                    list: widget.bloc.listCollateralTokenFilter,
                  ),
                ),
                spaceH40,
                GestureDetector(
                  onTap: () {
                    widget.bloc.funFilter();
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
        ),
      ),
    );
  }
}
