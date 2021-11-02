import 'dart:ui';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/bloc_creare_seedphrase.dart';

void showCreateSeedPhrase2(
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
          color: const Color(0xff24234C),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap the words to put them next to each other in \n'
                  'the corect order',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 20.h,
                ),
                StreamBuilder(
                  stream: bLocCreateSeedPhrase.listTitle,
                  builder: (context, AsyncSnapshot<List<Item>> snapshot) {
                    final listTitle = snapshot.data;
                    return Column(
                      children: [
                        BoxListPassWordPhrase(
                          listTitle: listTitle ?? [],
                          bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        ListPassPhrase(
                          listTitle: listTitle ?? [],
                          bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 41.h,
                ),
                const CheckBoxCustom(
                  title: 'Do not provide your recovery key to anyone',
                ),
                SizedBox(
                  height: 80.h,
                ),
                GestureDetector(
                  onTap: () {
                    print('Create');
                  },
                  child: const ButtonGold(
                    title: 'Create',
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
