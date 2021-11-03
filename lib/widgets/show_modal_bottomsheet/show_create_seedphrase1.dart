import 'dart:ui';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/from/from_text.dart';
import 'package:Dfy/widgets/header_create/header_create.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrasse_copy.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/show_create_seedphrare2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc_creare_seedphrase.dart';

void showCreateSeedPhrase1(
    BuildContext context, BLocCreateSeedPhrase blocCreateSeedPhrase) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: 764.h,
        width: 375.w,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: const Color(0xff3e3d5c),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 28.h,
              width: 323.w,
              margin: EdgeInsets.only(right: 26.w, left: 26.w, top: 16.h),
              child: const HeaderCreate(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FromText(
                      title: 'Wallet name',
                      urlSuffixIcon: '',
                      urlPrefixIcon: 'assets/images/wallet.png',
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const FromText(
                      title: 'Wallet name',
                      urlSuffixIcon: 'assets/images/copy.png',
                      urlPrefixIcon: 'assets/images/address.png',
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const FromText(
                      title: 'Private key',
                      urlSuffixIcon: 'assets/images/copy.png',
                      urlPrefixIcon: 'assets/images/key.png',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      children: [
                        BoxListPassWordPhraseCopy(
                          listTitle: blocCreateSeedPhrase.listTitle1,
                        ),
                        SizedBox(
                          height: 17.h,
                        ),
                        const CheckBoxCustom(
                          title: 'Do not provide your recovery key to anyone',
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showCreateSeedPhrase2(context, blocCreateSeedPhrase);
                },
                child: const ButtonGold(
                  title: 'Continue',
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
