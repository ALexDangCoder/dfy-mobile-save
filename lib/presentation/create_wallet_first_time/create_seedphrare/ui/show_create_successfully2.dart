import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum KeyType { IMPORT, CREATE }

void showCreateSuccessfully2({
  required BuildContext context,
  required Wallet wallet,
  required KeyType type,
}) {
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
            SizedBox(
              height: 18.h,
            ),
            Center(
              child: Text(
                type == KeyType.CREATE
                    ? S.current.success
                    : S.current.success_import,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            spaceH20,
            line,
            spaceH24,
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Image.asset(ImageAssets.icFrame),
                    spaceH20,
                    Text(
                      S.current.congratulation,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                    SizedBox(
                      height: 213.h,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        index: 1,
                        wallet: wallet,
                      ),
                    ),
                  );
                },
                child: ButtonGold(
                  title: S.current.complete,
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
