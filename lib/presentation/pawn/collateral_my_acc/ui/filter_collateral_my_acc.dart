import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_filter/is_base_checkbox_activity.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/personal_lending_hard/ui/is_base_check_box_hard.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_widget_filter.dart';

class FilterCollateralMyAcc extends StatefulWidget {
  const FilterCollateralMyAcc({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final CollateralMyAccBloc bloc;

  @override
  _FilterCollateralMyAccState createState() => _FilterCollateralMyAccState();
}

class _FilterCollateralMyAccState extends State<FilterCollateralMyAcc> {
  @override
  void initState() {
    super.initState();
    widget.bloc.statusFilterFirst();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () {
              if (bloc.checkWalletAddress) {
                bloc.isChooseAcc.sink.add(false);
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
                              widget.bloc.funReset();
                              setState(() {

                              });
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
                    Container(
                      padding: EdgeInsets.only(
                        left: 6.w,
                        right: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (bloc.checkWalletAddress) {
                                  bloc.isChooseAcc.sink.add(true);
                                }
                              },
                              child: StreamBuilder<String>(
                                stream: bloc.textAddressFilter,
                                builder: (context, snapshot) {
                                  final String address =
                                      bloc.checkAddress(snapshot.data ?? '');
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 16.h,
                                      bottom: 12.h,
                                      left: 10.w,
                                    ),
                                    height: 46.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.5.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.getInstance()
                                          .itemBtsColors(),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: Image.asset(
                                                ImageAssets.ic_wallet,
                                                height: 20.67.h,
                                                width: 20.14.w,
                                              ),
                                            ),
                                            spaceW6,
                                            SizedBox(
                                              child: Text(
                                                address,
                                                style: textNormal(
                                                  null,
                                                  16,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          child: bloc.checkWalletAddress
                                              ? Image.asset(
                                                  ImageAssets.ic_line_down,
                                                  height: 20.67.h,
                                                  width: 20.14.w,
                                                )
                                              : SizedBox(
                                                  height: 20.67.h,
                                                  width: 20.14.w,
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(
                              S.current.loan_token,
                              style:
                                  textNormalCustom(null, 16, FontWeight.w600),
                            ),
                          ),
                          spaceH16,
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: ItemWidgetFilter(
                              bloc: widget.bloc,
                              list: widget.bloc.listLoanTokenFilter,
                              type: TypeCheckBox.LOAN,
                            ),
                          ),
                          spaceH16,
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(
                              S.current.collateral,
                              style:
                                  textNormalCustom(null, 16, FontWeight.w600),
                            ),
                          ),
                          spaceH16,
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: ItemWidgetFilter(
                              bloc: widget.bloc,
                              list: widget.bloc.listCollateralTokenFilter,
                              type: TypeCheckBox.COLLATERAL,
                            ),
                          ),
                          spaceH16,
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Text(
                              S.current.status,
                              style:
                                  textNormalCustom(null, 16, FontWeight.w600),
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
                                  flex: 10,
                                  child: IsBaseCheckBoxHard(
                                    title: S.current.all,
                                    stream: widget.bloc.isAll,
                                    funText: widget.bloc.check,
                                    funCheckBox: widget.bloc.check,
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: IsBaseCheckBoxHard(
                                    title: S.current.open,
                                    stream: widget.bloc.isOpen,
                                    funText: widget.bloc.check,
                                    funCheckBox: widget.bloc.check,
                                  ),
                                ),
                              ],
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
                                  flex: 10,
                                  child: IsBaseCheckBoxHard(
                                    title: S.current.accepted,
                                    stream: widget.bloc.isAccepted,
                                    funText: widget.bloc.check,
                                    funCheckBox: widget.bloc.check,
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: IsBaseCheckBoxHard(
                                    title: S.current.withdraw,
                                    stream: widget.bloc.isWithDrawn,
                                    funText: widget.bloc.check,
                                    funCheckBox: widget.bloc.check,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          spaceH60,
                        ],
                      ),
                    ),
                    spaceH60,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                top: 16.h,
              ),
              color: AppTheme.getInstance().bgBtsColor(),
              child: GestureDetector(
                onTap: () {
                  bloc.funFilter();
                  Navigator.pop(context);
                },
                child: ButtonLuxury(
                  title: S.current.apply,
                  isEnable: true,
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: bloc.isChooseAcc,
            builder: (ctx, snapshot) {
              return Visibility(
                visible: snapshot.data ?? false,
                child: Positioned(
                  top: 150.h,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().colorTextReset(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    width: 343.w,
                    height: 123.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: bloc.listAcc.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bloc.chooseAddressFilter(bloc.listAcc[index]);
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                              top: 15.h,
                            ),
                            color: bloc.listAcc[index] ==
                                    bloc.textAddressFilter.value
                                ? AppTheme.getInstance()
                                    .whiteColor()
                                    .withOpacity(0.3)
                                : Colors.transparent,
                            child: Text(
                              bloc.listAcc[index] == S.current.all
                                  ? S.current.all
                                  : bloc.checkNullAddressWallet(
                                      bloc.listAcc[index],
                                    ),
                              style: textNormalCustom(null, 16, null),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
