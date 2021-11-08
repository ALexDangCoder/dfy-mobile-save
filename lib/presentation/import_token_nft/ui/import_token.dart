import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

import '../../../main.dart';
import 'choose_token.dart';
import 'enter_address.dart';

void showImportToken(BuildContext context, ImportTokenNftBloc bloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      // bloc.importToken(
      //     walletAddress: "walletAddress",
      //     tokenAddress: "tokenAddress",
      //     symbol: "dsfsadf",
      //     decimal: 1);
      bloc.getListSupportedToken(walletAddress: "walletAddress");
      trustWalletChannel.setMethodCallHandler(
        bloc.nativeMethodCallBackTrustWallet,
      ); //final textController = TextEditingController();
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
                    left: 26.w, top: 16.h, right: 26.w, bottom: 20.h),
                child: Row(
                  
                  children: [
                    spaceW5,
                    GestureDetector(
                      child: Image.asset(
                        url_ic_out,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only( left: 90.w),
                      child: Text(Strings.import_token,
                          style: textNormalCustom(null, 20, FontWeight.bold)),
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
                    tabs: const [
                      Tab(
                        text: Strings.enter_token,
                      ),
                      Tab(
                        text: Strings.choose_token,
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
  );
}
