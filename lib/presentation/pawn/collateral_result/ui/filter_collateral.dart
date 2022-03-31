import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_widget_filter.dart';
import 'item_widget_text_list_filter.dart';

class FilterCollateral extends StatefulWidget {
  const FilterCollateral({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CollateralResultBloc bloc;

  @override
  _FilterCollateralState createState() => _FilterCollateralState();
}

class _FilterCollateralState extends State<FilterCollateral> {
  late TextEditingController textSearch;

  @override
  void initState() {
    super.initState();
    textSearch = TextEditingController();
    widget.bloc.statusFilterFirst();
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
          height: 812.h,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
              spaceH12,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH12,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.collateral,
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
                          type: TypeCheckBox.COLLATERAL,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.loan_token,
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
                          list: widget.bloc.listLoanTokenFilter,
                          type: TypeCheckBox.LOAN,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Text(
                          S.current.duration,
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
                          horizontal: 7.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: IsBaseCheckBox(
                                title: S.current.week,
                                stream: widget.bloc.isWeek,
                                funText: () {},
                                funCheckBox: () {},
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: IsBaseCheckBox(
                                title: S.current.month,
                                stream: widget.bloc.isMonth,
                                funText: () {},
                                funCheckBox: () {},
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
                          S.current.networks,
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
                        child: ItemWidgetTextFilter(
                          bloc: widget.bloc,
                          list: widget.bloc.listNetworkFilter,
                        ),
                      ),
                      spaceH40,
                    ],
                  ),
                ),
              ),
              spaceH8,
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
    );
  }
}
