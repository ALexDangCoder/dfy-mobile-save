import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/widget/checkbox_multichoice.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBorrow extends StatefulWidget {
  const FilterBorrow({Key? key, required this.cubit}) : super(key: key);

  final BorrowResultCubit cubit;

  @override
  _FilterBorrowState createState() => _FilterBorrowState();
}

class _FilterBorrowState extends State<FilterBorrow> {
  TextEditingController controller = TextEditingController();
  ScrollController collateralController = ScrollController();
  ScrollController loanTokenController = ScrollController();
  ScrollController networkController = ScrollController();

  @override
  void initState() {
    super.initState();
    if(widget.cubit.cachedName != ''){
      controller.text = widget.cubit.cachedName;
    }
    widget.cubit.listInterest = widget.cubit.listCachedInterest;
    widget.cubit.listLoan = widget.cubit.listCachedLoan;
    widget.cubit.checkShowCollateral();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          height: 764.h,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Column(
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
                      Row(
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
                              widget.cubit.focusTextField.add('');
                              controller.text = '';
                              FocusScope.of(context).unfocus();
                              widget.cubit.resetFilter();
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
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  physics: const ScrollPhysics(),
                  child: StreamBuilder<String>(
                    stream: widget.cubit.interestRate,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceH10,
                          Container(
                            height: 46.h,
                            padding: EdgeInsets.only(right: 15.w, left: 15.w),
                            decoration: BoxDecoration(
                              color: AppTheme.getInstance().backgroundBTSColor(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageAssets.ic_search,
                                  height: 16.h,
                                  width: 16.w,
                                ),
                                SizedBox(
                                  width: 10.7.w,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: controller,
                                    maxLength: 100,
                                    onChanged: (value) {
                                      widget.cubit.focusTextField.add(value);
                                    },
                                    cursorColor:
                                        AppTheme.getInstance().whiteColor(),
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      isCollapsed: true,
                                      counterText: '',
                                      hintText: S.current.search_pawnshop,
                                      hintStyle: textNormal(
                                        Colors.white.withOpacity(0.5),
                                        16,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                  stream: widget.cubit.focusTextField,
                                  builder:
                                      (context, AsyncSnapshot<String> snapshot) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.cubit.focusTextField.add('');
                                        controller.text = '';
                                      },
                                      child: (snapshot.data != '')
                                          ? Image.asset(
                                              ImageAssets.ic_close,
                                              width: 20.w,
                                              height: 20.h,
                                            )
                                          : SizedBox(
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          spaceH16,
                          Text(
                            S.current.interest_range,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          StreamBuilder<String>(
                            stream: widget.cubit.interestRate,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.INTEREST_1,
                                      filterType: S.current.interest_range,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listInterest[
                                          widget.cubit.getIndexInterest(
                                        BorrowResultCubit.INTEREST_1,
                                      )],
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.INTEREST_2,
                                      filterType: S.current.interest_range,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listInterest[
                                          widget.cubit.getIndexInterest(
                                        BorrowResultCubit.INTEREST_2,
                                      )],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          spaceH16,
                          StreamBuilder<String>(
                            stream: widget.cubit.interestRate,
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.INTEREST_3,
                                      filterType: S.current.interest_range,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listInterest[
                                          widget.cubit.getIndexInterest(
                                        BorrowResultCubit.INTEREST_3,
                                      )],
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.INTEREST_4,
                                      filterType: S.current.interest_range,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listInterest[
                                          widget.cubit.getIndexInterest(
                                        BorrowResultCubit.INTEREST_4,
                                      )],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          spaceH16,
                          Text(
                            S.current.loan_to_value,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          StreamBuilder<String>(
                            stream: widget.cubit.interestRate,
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.LOAN_VL1,
                                      filterType: S.current.loan_to_value,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listLoan[
                                          widget.cubit.getIndexLoanToValue(
                                        BorrowResultCubit.LOAN_VL1,
                                      )],
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.LOAN_VL2,
                                      filterType: S.current.loan_to_value,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listLoan[
                                          widget.cubit.getIndexLoanToValue(
                                        BorrowResultCubit.LOAN_VL2,
                                      )],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          spaceH16,
                          StreamBuilder<String>(
                            stream: widget.cubit.interestRate,
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.LOAN_VL3,
                                      filterType: S.current.loan_to_value,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listLoan[
                                          widget.cubit.getIndexLoanToValue(
                                        BorrowResultCubit.LOAN_VL3,
                                      )],
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckBoxMultiChoice(
                                      nameCkcFilter: BorrowResultCubit.LOAN_VL4,
                                      filterType: S.current.loan_to_value,
                                      typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                      cubit: widget.cubit,
                                      isSelected: widget.cubit.listLoan[
                                          widget.cubit.getIndexLoanToValue(
                                        BorrowResultCubit.LOAN_VL4,
                                      )],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          spaceH16,
                          Text(
                            S.current.collateral_accepted,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 138.h,
                            width: 343.w,
                            padding: EdgeInsets.only(
                              right: 6.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: divideColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                            ),
                            child: Theme(
                              data: ThemeData(
                                highlightColor:
                                    AppTheme.getInstance().colorTextReset(),
                              ),
                              child: Scrollbar(
                                radius: Radius.circular(20.r),
                                thickness: 4.w,
                                isAlwaysShown: true,
                                controller: collateralController,
                                child: GridView.builder(
                                  controller: collateralController,
                                  itemCount: widget.cubit.listCollateral.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 55 / 15,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 5.h,
                                    bottom: 5.h,
                                    left: 16.w,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return CheckBoxMultiChoice(
                                      nameCkcFilter: widget.cubit
                                              .listCollateral[index].symbol ??
                                          '',
                                      filterType: S.current.collateral_accepted,
                                      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
                                      urlCover: widget.cubit
                                              .listCollateral[index].iconUrl ??
                                          '',
                                      cubit: widget.cubit,
                                      isSelected: widget
                                          .cubit.listCollateral[index].isSelect,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          spaceH16,
                          Text(
                            S.current.loan_token,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 138.h,
                            width: 343.w,
                            padding: EdgeInsets.only(
                              right: 6.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: divideColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                            ),
                            child: Theme(
                              data: ThemeData(
                                highlightColor:
                                    AppTheme.getInstance().colorTextReset(),
                              ),
                              child: Scrollbar(
                                radius: Radius.circular(20.r),
                                thickness: 4.w,
                                isAlwaysShown: true,
                                controller: loanTokenController,
                                child: GridView.builder(
                                  controller: loanTokenController,
                                  itemCount: widget.cubit.listLoanToken.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 55 / 15,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: 5.h,
                                    bottom: 5.h,
                                    left: 16.w,
                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    return CheckBoxMultiChoice(
                                      nameCkcFilter: widget.cubit
                                              .listLoanToken[index].symbol ??
                                          '',
                                      filterType: S.current.loan_token,
                                      typeCkc: TYPE_CKC_FILTER.HAVE_IMG,
                                      urlCover: widget.cubit.listLoanToken[index]
                                              .iconUrl ??
                                          '',
                                      cubit: widget.cubit,
                                      isSelected: widget
                                          .cubit.listLoanToken[index].isSelect,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          spaceH16,
                          Text(
                            S.current.loan_type,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          Row(
                            children: [
                              Expanded(
                                child: CheckBoxMultiChoice(
                                  nameCkcFilter: S.current.auto,
                                  filterType: S.current.loan_type,
                                  typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                  cubit: widget.cubit,
                                  isSelected:
                                      widget.cubit.listLoanType[0].isSelect,
                                ),
                              ),
                              Expanded(
                                child: CheckBoxMultiChoice(
                                  nameCkcFilter: S.current.semi_auto,
                                  filterType: S.current.loan_type,
                                  typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                  cubit: widget.cubit,
                                  isSelected:
                                      widget.cubit.listLoanType[1].isSelect,
                                ),
                              ),
                            ],
                          ),
                          spaceH16,
                          Text(
                            S.current.duration,
                            style: textNormalCustom(
                              Colors.white,
                              16,
                              FontWeight.w600,
                            ),
                          ),
                          spaceH16,
                          Row(
                            children: [
                              Expanded(
                                child: CheckBoxMultiChoice(
                                  nameCkcFilter: S.current.week,
                                  filterType: S.current.duration,
                                  typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                  cubit: widget.cubit,
                                  isSelected:
                                      widget.cubit.listDuration[0].isSelect,
                                ),
                              ),
                              Expanded(
                                child: CheckBoxMultiChoice(
                                  nameCkcFilter: S.current.month,
                                  filterType: S.current.duration,
                                  typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                  cubit: widget.cubit,
                                  isSelected:
                                      widget.cubit.listDuration[1].isSelect,
                                ),
                              ),
                            ],
                          ),
                          // spaceH16,
                          // Text(
                          //   S.current.networks,
                          //   style: textNormalCustom(
                          //     Colors.white,
                          //     16,
                          //     FontWeight.w600,
                          //   ),
                          // ),
                          // spaceH16,
                          // Container(
                          //   clipBehavior: Clip.hardEdge,
                          //   height: 138.h,
                          //   width: 343.w,
                          //   padding: EdgeInsets.only(
                          //     right: 6.w,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: divideColor),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20.r)),
                          //   ),
                          //   child: Theme(
                          //     data: ThemeData(
                          //       highlightColor:
                          //           AppTheme.getInstance().colorTextReset(),
                          //     ),
                          //     child: Scrollbar(
                          //       radius: Radius.circular(20.r),
                          //       thickness: 4.w,
                          //       controller: networkController,
                          //       child: GridView.builder(
                          //         controller: networkController,
                          //         itemCount: widget.cubit.network.length,
                          //         shrinkWrap: true,
                          //         gridDelegate:
                          //             const SliverGridDelegateWithFixedCrossAxisCount(
                          //           crossAxisCount: 2,
                          //           mainAxisSpacing: 5,
                          //           crossAxisSpacing: 10,
                          //           childAspectRatio: 55 / 15,
                          //         ),
                          //         padding: EdgeInsets.only(
                          //           top: 5.h,
                          //           bottom: 5.h,
                          //           left: 16.w,
                          //         ),
                          //         itemBuilder: (BuildContext context, int index) {
                          //           return CheckBoxMultiChoice(
                          //             nameCkcFilter: widget
                          //                     .cubit.network[index].nameNetwork ??
                          //                 '',
                          //             filterType: S.current.networks,
                          //             typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          //             cubit: widget.cubit,
                          //             isSelected:
                          //                 widget.cubit.network[index].isSelect,
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 40.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.cubit.applyFilter(controller.text);
                              Navigator.pop(context);
                            },
                            child: ButtonRadial(
                              radius: 15,
                              height: 48.h,
                              child: Center(
                                child: Text(
                                  S.current.apply,
                                  style: textNormalCustom(
                                    Colors.white,
                                    16,
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
