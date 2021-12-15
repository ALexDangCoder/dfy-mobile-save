import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

import 'choose_token.dart';
import 'enter_address.dart';

class ImportTokenScreen extends StatelessWidget {
  const ImportTokenScreen({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);
  final WalletCubit bloc;
  final String addressWallet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 48.h,
          ),
          DefaultTabController(
            length: 2,
            child: Container(
              height: 764.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 343.w,
                    height: 28.h,
                    margin: EdgeInsets.only(
                      left: 16.w,
                      top: 16.h,
                      right: 16.w,
                      bottom: 20.h,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 10.w, left: 10.w),
                            child: Image.asset(
                              ImageAssets.ic_back,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 70.w),
                          child: Text(
                            S.current.import_token,
                            style: textNormalCustom(
                              null,
                              20.sp,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  line,
                  spaceH12,
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                        color: backgroundBottomSheetColor,
                      ),
                      height: 35.h,
                      width: 253.w,
                      child: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              S.current.enter_token,
                              style: textNormalCustom(
                                null,
                                14.sp,
                                FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              S.current.choose_token,
                              style: textNormalCustom(
                                null,
                                14.sp,
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        labelColor: AppTheme.getInstance().whiteColor(),
                        unselectedLabelColor:
                            AppTheme.getInstance().whiteColor(),
                        indicator: RectangularIndicator(
                          bottomLeftRadius: 10.r,
                          bottomRightRadius: 10.r,
                          topLeftRadius: 10.r,
                          topRightRadius: 10.r,
                          color: formColor,
                          horizontalPadding: 3.w,
                          verticalPadding: 3.h,
                        ),
                      ),
                    ),
                  ),
                  spaceH12,
                  line,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final FocusScopeNode currentFocus =
                            FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: TabBarView(
                        children: [
                          EnterAddress(
                            bloc: bloc,
                            addressWallet: addressWallet,
                          ),
                          ChooseToken(bloc: bloc),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
