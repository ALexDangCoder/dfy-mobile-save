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
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 812.h,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          width: 375.w,
          decoration: BoxDecoration(
            color: const Color(0xff3e3d5c),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
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
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.bold,
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
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            32,
                            FontWeight.bold,
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
                            index: walletInfoIndex,
                            wallet: wallet,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(
                            index: walletInfoIndex,
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
              spaceH38,
            ],
          ),
        ),
      ),
    );
  }
}
