import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/ckc_filter/ckc_filter.dart';
import 'package:Dfy/widgets/cool_drop_down/cool_drop_down.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterLoanRequestList extends StatefulWidget {
  const FilterLoanRequestList({Key? key}) : super(key: key);

  @override
  _FilterLoanRequestListState createState() => _FilterLoanRequestListState();
}

class _FilterLoanRequestListState extends State<FilterLoanRequestList> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
      child: Container(
        height: 704.h,
        padding: EdgeInsets.only(
          top: 33.h,
          left: 16.w,
          right: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerFtResetBtn(),
                spaceH20,
                _dropDownSelectWallet(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH16,
                        Text(
                          S.current.asset_type.capitalize(),
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        spaceH16,
                        CheckBoxFilterWidget(
                          typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          callBack: () {},
                          nameCkcFilter: S.current.all.capitalize(),
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.jewelry.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.art_work.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.car.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.watch.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.house.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.others.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Text(
                          S.current.nft_type.capitalize(),
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.all.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.active.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.soft_nft.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.hard_nft.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Text(
                          S.current.status.capitalize(),
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        spaceH16,
                        CheckBoxFilterWidget(
                          typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          callBack: () {},
                          nameCkcFilter: S.current.all.capitalize(),
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.accepted.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.open.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH16,
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.canceled.capitalize(),
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilterWidget(
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                callBack: () {},
                                nameCkcFilter: S.current.rejected.capitalize(),
                              ),
                            )
                          ],
                        ),
                        spaceH152,
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 38.h,
              child: SizedBox(
                width: 343.w,
                child: ButtonGradient(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.5),
                    radius: 4,
                    colors: AppTheme.getInstance().gradientButtonColor(),
                  ),
                  child: Text(
                    S.current.apply,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownSelectWallet() {
    return Stack(
      children: [
        CoolDropdown(
          // gap: 8.h,
          dropdownItemMainAxis: MainAxisAlignment.start,
          resultMainAxis: MainAxisAlignment.spaceEvenly,
          dropdownList: [],
          onChange: (value) {
            value as Map<String, dynamic>;
          },
          dropdownItemHeight: 54.h,
          dropdownHeight: 232.h,
          dropdownWidth: 343.w,
          resultAlign: Alignment.centerRight,
          resultWidth: 343.w,
          resultHeight: 64.h,
          dropdownPadding: EdgeInsets.only(right: 11.w),
          dropdownBD: BoxDecoration(
            color: AppTheme.getInstance().selectDialogColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultBD: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          resultTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholder: S.current.select_wallet_address,
          resultIcon: const SizedBox.shrink(),
          selectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          unselectedItemTS: textNormal(
            AppTheme.getInstance().whiteColor(),
            16,
          ),
          placeholderTS: textNormal(
            Colors.white.withOpacity(0.5),
            16,
          ),
          isTriangle: false,
          selectedItemBD: BoxDecoration(
            color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
          ),
        ),
        Positioned(
          left: 7.w,
          child: SizedBox(
            height: 64.h,
            child: Image.asset(ImageAssets.ic_wallet),
          ),
        ),
        Positioned(
          right: 25.w,
          child: SizedBox(
            height: 64.h,
            child: Image.asset(ImageAssets.ic_copy),
          ),
        ),
        Positioned(
          right: 19.w,
          child: SizedBox(
            height: 64.h,
            child: sizedSvgImage(
              w: 13,
              h: 13,
              image: ImageAssets.ic_expand_white_svg,
            ),
          ),
        )
      ],
    );
  }

  Widget _headerFtResetBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 3,
          child: Container(),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.filter,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20,
                  FontWeight.w600,
                ),
              ),
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(
                  vertical: 6.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.r),
                  ),
                  color: AppTheme.getInstance().skeleton(),
                ),
                child: Text(
                  S.current.reset,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
