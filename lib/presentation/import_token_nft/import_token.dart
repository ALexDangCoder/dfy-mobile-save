import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showImportToken(BuildContext context) {
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
              Divider(
                height: 1.h,
                color: const Color.fromRGBO(255, 255, 255, 0.1),
              ),
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
              Divider(
                height: 1.h,
                color: const Color.fromRGBO(255, 255, 255, 0.1),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [

                        ],
                      ),
                    ),
                    Container(
                      color: Colors.red,
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
