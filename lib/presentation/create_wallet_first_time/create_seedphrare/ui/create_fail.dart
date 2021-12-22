import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateFail extends StatelessWidget {
  const CreateFail({Key? key, required this.type}) : super(key: key);
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
                    (KeyType.CREATE == type ||
                            KeyType.CREATE_HAVE_WALLET == type)
                        ? S.current.create_new_wallet_failed
                        : S.current.import_new_wallet_failed,
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
                            child: Image.asset(ImageAssets.img_fail),
                          ),
                          spaceH20,
                          Center(
                            child: Text(
                              S.current.oopps_omething_went_wrong,
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                32,
                                FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
                      if (type == KeyType.CREATE) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              index: 3,
                            ),
                          ),
                        );
                      } else if (type == KeyType.CREATE_HAVE_WALLET) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              index: 1,
                            ),
                          ),
                        );
                      } else if (type == KeyType.IMPORT) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              index: 3,
                            ),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(
                              index: 1,
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
