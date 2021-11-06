import 'dart:ui';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';
import 'package:Dfy/widgets/form/form_input2.dart';
import 'package:Dfy/widgets/form/form_input3.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showImportNft(BuildContext context, ImportTokenNftBloc bloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    //isDismissible: false,
    //enableDrag: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
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
                    margin: EdgeInsets.only(right: 88.w, left: 90.w),
                    child: Text(Strings.import_token,
                        style: textNormalCustom(null, 20, FontWeight.bold)),
                  ),
                ],
              ),
            ),
            line,
            spaceH24,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormInput3(
                        urlIcon2: url_ic_qr,
                        bloc: bloc,
                        urlIcon1: url_ic_address,
                        hint: Strings.contract_address,
                      ),
                      spaceH16,
                      FormInputNumber(
                        urlIcon1: url_ic_enter_id,
                        bloc: bloc,
                        hint: Strings.enter_id,
                      ),
                      const SizedBox(
                        height: 429,
                      ),
                    ],
                  ),
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
      );
    },
  );
}
