import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrare2.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/form/form_text.dart';
import 'package:Dfy/widgets/header_create/header_create.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrasse_copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

void showCreateSeedPhrase1(
  BuildContext context,
  BLocCreateSeedPhrase blocCreateSeedPhrase,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      if (blocCreateSeedPhrase.passPhrase.isEmpty) {
        blocCreateSeedPhrase.generateWallet(
          password: blocCreateSeedPhrase.passWord,
        );
      }
      trustWalletChannel.setMethodCallHandler(
        blocCreateSeedPhrase.nativeMethodCallBackTrustWallet,
      );

      final nameWallet = TextEditingController();
      return StreamBuilder(
        stream: blocCreateSeedPhrase.isCheckData,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return GestureDetector(
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
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
                      margin:
                          EdgeInsets.only(right: 26.w, left: 26.w, top: 16.h),
                      child: const HeaderCreate(),
                    ),
                    spaceH20,
                    line,
                    spaceH24,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 323.w,
                              height: 64.h,
                              margin: EdgeInsets.symmetric(horizontal: 26.w),
                              padding: EdgeInsets.only(right: 15.w, left: 15.w),
                              decoration: const BoxDecoration(
                                color: Color(0xff32324c),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    url_ic_wallet,
                                    height: 17.67.h,
                                    width: 19.14.w,
                                  ),
                                  SizedBox(
                                    width: 20.5.w,
                                  ),
                                  Expanded(
                                    child: StreamBuilder(
                                      stream: blocCreateSeedPhrase.nameWallet,
                                      builder: (context,
                                          AsyncSnapshot<String> snapshot) {
                                        nameWallet.text = snapshot.data ?? '';
                                        return Container(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: TextFormField(
                                            controller: nameWallet,
                                            onChanged: (value) {
                                              blocCreateSeedPhrase
                                                  .nameWallet.sink
                                                  .add(value);
                                            },
                                            cursorColor: Colors.white,
                                            style: textNormal(
                                              Colors.white54,
                                              16.sp,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Name Wallet',
                                              hintStyle: textNormal(
                                                Colors.white54,
                                                16.sp,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                            // onFieldSubmitted: ,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      blocCreateSeedPhrase.nameWallet.sink
                                          .add('');
                                    },
                                    child: Image.asset(
                                      url_ic_close,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            FromText(
                              title: blocCreateSeedPhrase.walletAddress,
                              urlSuffixIcon: 'assets/images/ic_copy.png',
                              urlPrefixIcon: 'assets/images/ic_address.png',
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            FromText(
                              title: blocCreateSeedPhrase.privateKey,
                              urlSuffixIcon: 'assets/images/ic_copy.png',
                              urlPrefixIcon: 'assets/images/ic_key.png',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                BoxListPassWordPhraseCopy(
                                  listTitle: blocCreateSeedPhrase.listTitle1,
                                  bLocCreateSeedPhrase: blocCreateSeedPhrase,
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                                CheckBoxCustom(
                                  title:
                                      'Do not provide your recovery key to anyone',
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
                            showCreateSeedPhrase2(
                                context, blocCreateSeedPhrase);
                          }
                        },
                        child: StreamBuilder(
                          stream: blocCreateSeedPhrase.isCheckBox1,
                          builder: (context, snapshot) {
                            return ButtonGold(
                              title: 'Continue',
                              isEnable: blocCreateSeedPhrase.isCheckBox1.value,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
