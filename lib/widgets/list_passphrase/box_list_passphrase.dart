import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxListPassWordPhrase extends StatelessWidget {
  final List<String> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const BoxListPassWordPhrase({
    Key? key,
    required this.listTitle,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 214.h,
        minWidth: 343.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().itemBtsColors(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.only(
          top: 16.h,
          left: 13.w,
          right: 13.w,
          bottom: 10.h,
        ),
        child: Wrap(
          spacing: 5.w,
          runSpacing: 12.h,
          children: List<Widget>.generate(
            listTitle.length,
            (int index) {
              return GestureDetector(
                onTap: () {
                  bLocCreateSeedPhrase.addListSeedPhrase(listTitle[index]);
                  bLocCreateSeedPhrase.removeListBoxSeedPhrase(index);
                },
                child: ItemSeedPhrase(
                  title: '${index + 1}. ${listTitle[index]}',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
