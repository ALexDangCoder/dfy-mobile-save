import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom2.dart';
import 'package:Dfy/widgets/header_create/header_create.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSeedPhrase2(
  BuildContext context,
  BLocCreateSeedPhrase bLocCreateSeedPhrase,
) {
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
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 26.w, left: 26.w),
                      child: Text(
                        S.current.tap_the_word,
                        style: textNormal(
                          AppTheme.getInstance().textThemeColor(),
                          16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      children: [
                        StreamBuilder(
                          stream: bLocCreateSeedPhrase.listSeedPhrase,
                          builder:
                              (context, AsyncSnapshot<List<Item>> snapshot) {
                            final listSeedPhrase = snapshot.data;
                            return BoxListPassWordPhrase(
                              listTitle: listSeedPhrase ?? [],
                              bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                            );
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        StreamBuilder(
                          stream: bLocCreateSeedPhrase.listTitle,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<List<Item>> snapshot,
                          ) {
                            final listTitle = snapshot.data;
                            return ListPassPhrase(
                              listTitle: listTitle ?? [],
                              bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 41.h,
                    ),
                    CheckBoxCustom2(
                      title: S.current.i_understand,
                      bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (bLocCreateSeedPhrase.isCheckBox2.value &&
                      bLocCreateSeedPhrase.getCheck()) {
                    showCreateSuccessfully(context);
                  }
                },
                child: ButtonGold(
                  title: S.current.create,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
