import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

import '../../../main.dart';
import 'choose_token.dart';
import 'enter_address.dart';

void showImportToken(BuildContext context, WalletCubit bloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      bloc.getListSupportedToken(
        walletAddress: 'walletAddress',
      );
      trustWalletChannel.setMethodCallHandler(
        bloc.nativeMethodCallBackTrustWallet,
      );
      return DefaultTabController(
        length: 2,
        child: Container(
          height: 764.h,
          width: 375.w,
          decoration: const BoxDecoration(
            color: Color(0xff3e3d5c),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 323.w,
                height: 28.h,
                margin: EdgeInsets.only(
                  left: 26.w,
                  top: 16.h,
                  right: 26.w,
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
                        style: textNormalCustom(null, 20, FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              line,
              spaceH12,
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: backGroubBottomSheetColor,
                  ),
                  height: 35.h,
                  width: 253.w,
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: S.current.enter_token,
                      ),
                      Tab(
                        text: S.current.choose_token,
                      ),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: RectangularIndicator(
                      bottomLeftRadius: 10,
                      bottomRightRadius: 10,
                      topLeftRadius: 10,
                      topRightRadius: 10,
                      color: formColor,
                      horizontalPadding: 3,
                      verticalPadding: 3,
                    ),
                  ),
                ),
              ),
              spaceH12,
              line,
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: TabBarView(
                    children: [
                      EnterAddress(
                        bloc: bloc,
                      ),
                      ChooseToken(bloc: bloc),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  ).whenComplete(
    () => {
      bloc.getListTokenItem(),
      bloc.totalBalance.add(
        bloc.total(bloc.listTokenStream.value),
      ),
    },
  );
}
