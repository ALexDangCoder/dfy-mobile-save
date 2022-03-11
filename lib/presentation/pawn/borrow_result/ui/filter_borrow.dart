import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
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

  @override
  void initState() {
    super.initState();
    // widget.cubit.listCheckStatus = widget.cubit.cachedStatus;
    // widget.cubit.listCheckAssetType = widget.cubit.cachedAssetType;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        height: 700.h,
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
                          // widget.cubit.resetFilter();
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
            )),
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH10,
                    Container(
                      height: 46.h,
                      padding: EdgeInsets.only(right: 15.w, left: 15.w),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().backgroundBTSColor(),
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
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
                              cursorColor: AppTheme.getInstance().whiteColor(),
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
                            builder: (context, AsyncSnapshot<String> snapshot) {
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

                    /// Filter interest range
                    spaceH16,

                    /// Filter interest range
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

                    /// Filter loan to vl
                    spaceH16,

                    /// Filter loan to vl
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
                      height: 138.h,
                      width: 343.w,
                      decoration: BoxDecoration(),

                      /// Filter collateral accept
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
                      height: 138.h,
                      width: 343.w,
                      decoration: BoxDecoration(),

                      /// Filter loan token
                    ),
                    spaceH16,
                    Text(
                      'Loan type',
                      style: textNormalCustom(
                        Colors.white,
                        16,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH16,

                    /// Filter loan type
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

                    /// Filter duration
                    spaceH16,
                    Text(
                      S.current.networks,
                      style: textNormalCustom(
                        Colors.white,
                        16,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH16,
                    Container(
                      height: 138.h,
                      width: 343.w,
                      decoration: BoxDecoration(),

                      /// Network
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ButtonGold(
                        isEnable: true,
                        title: S.current.apply,
                        height: 48.h,
                        textSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
