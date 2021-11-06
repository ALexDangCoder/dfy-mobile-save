import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrare2.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/form/form_text.dart';
import 'package:Dfy/widgets/header_create/header_create.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrasse_copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSeedPhrase1(
  BuildContext context,
  BLocCreateSeedPhrase blocCreateSeedPhrase,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      blocCreateSeedPhrase.generateWallet(
        password: blocCreateSeedPhrase.passWord,
      );
      trustWalletChannel.setMethodCallHandler(
        blocCreateSeedPhrase.nativeMethodCallBackTrustWallet,
      );

      return StreamBuilder(
        stream: blocCreateSeedPhrase.isCheckData,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Container(
              height: 764.h,
              width: 375.w,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                color: AppTheme.getInstance().bgBtsColor(),
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
                          FromText(
                            title: '${S.current.account} 1',
                            urlSuffixIcon: '',
                            urlPrefixIcon: ImageAssets.ic_wallet,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: blocCreateSeedPhrase.walletAddress,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.ic_address,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: blocCreateSeedPhrase.privateKey,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.key,
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
                              CheckBoxCustom(
                                title: S.current.do_not,
                                bLocCreateSeedPhrase: blocCreateSeedPhrase,
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
                        if (blocCreateSeedPhrase.isCheckBox1.value) {
                          showCreateSeedPhrase2(context, blocCreateSeedPhrase);
                        }
                      },
                      child: ButtonGold(
                        title: S.current.continue_s,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    },
  );
}
