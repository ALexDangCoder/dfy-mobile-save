import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateSuccessfullyHaveWallet extends StatelessWidget {
  const CreateSuccessfullyHaveWallet({
    Key? key,
    required this.wallet,
    required this.type,
  }) : super(key: key);

  final Wallet wallet;
  final KeyType type;

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
          Container(
            height: 764.h,
            width: 375.w,
            decoration: BoxDecoration(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80.h,
                          ),
                          SizedBox(
                            height: 228.h,
                            width: 305.w,
                            child: Image.asset(ImageAssets.frameGreen),
                          ),
                          spaceH20,
                          Text(
                            S.current.congratulation,
                            style: TextStyle(
                              color: AppTheme.getInstance().whiteColor(),
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
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (type == KeyType.CREATE_HAVE_WALLET) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              index: 1,
                              wallet: wallet,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              index: 1,
                              wallet: wallet,
                            ),
                          ),
                        );
                      }
                    },
                    child: ButtonGold(
                      title: S.current.complete,
                      isEnable: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
