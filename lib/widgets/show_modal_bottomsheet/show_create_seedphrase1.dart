import 'dart:ui';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/from/from_text.dart';
import 'package:Dfy/widgets/item_create/item_passphrase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc_creare_seedphrase.dart';

void showCreateSeedPhrase1(
    BuildContext context, BLocCreateSeedPhrase bLocCreateSeedPhrase) {
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
          color: Color(0xff24234C),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/out.png',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 66.w,
                  ),
                  Text(
                    'Create new wallet',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 64.w,
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/close.png',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              height: 1.h,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            SizedBox(
              height: 24.h,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ItemPassPhrase(
                      //   listTitle: bLocCreateSeedPhrase.listTitle,
                      // ),
                      SizedBox(
                        height: 17.h,
                      ),
                      CheckBoxCustom(
                        title: 'Do not provide your recovery key to anyone',
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('continue');
                        },
                        child: const ButtonGold(
                          title: 'Continue',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
