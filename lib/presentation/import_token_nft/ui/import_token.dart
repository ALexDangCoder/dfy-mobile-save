import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';
import 'package:Dfy/widgets/form/form_input2.dart';
import 'package:Dfy/widgets/form/form_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

void showImportToken(BuildContext context, ImportTokenBloc bloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DefaultTabController(
        length: 2,
        initialIndex: 0,
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
                      margin: EdgeInsets.only(right: 83.w, left: 100.w),
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
                child: TabBarView(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  spaceH24,
                                  FormInput(
                                    urlIcon2: url_ic_qr,
                                    bloc: bloc,
                                    urlIcon1: url_ic_address,
                                    hint: Strings.token_address,
                                  ),
                                  spaceH16,
                                  FormInput2(
                                    urlIcon1: url_ic_symbol,
                                    bloc: bloc,
                                    hint: Strings.token_symbol,
                                  ),
                                  spaceH16,
                                  FormInput2(
                                    urlIcon1: url_ic_decimal,
                                    bloc: bloc,
                                    hint: Strings.token_decimal,
                                  ),
                                  SizedBox(
                                    height: 289.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: const ButtonGold(
                                title: Strings.import,
                                isEnable: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xff3e3d5c),
                      child: Column(
                        children: [
                          spaceH12,
                          FormSearch(
                            hint: Strings.token_search,
                            bloc: bloc,
                            urlIcon1: url_ic_search,
                          ),
                          spaceH12,
                          line,
                          spaceH24,
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 73,
                                  width: 322,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          'assets/images/Ellipse 39.png'),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Bitcoin"),
                                              Text("BTC"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("0.621,54"),
                                              Text("BTC"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
