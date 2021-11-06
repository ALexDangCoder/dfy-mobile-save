import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxListPassWordPhrase extends StatelessWidget {
  final List<Item> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const BoxListPassWordPhrase({
    Key? key,
    required this.listTitle,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(top: 16.h, left: 13.w, right: 13.w),
      height: 214.h,
      width: 323.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 5.w,
            runSpacing: 12.h,
            children: List<Widget>.generate(
              listTitle.length,
              (int index) {
                return GestureDetector(
                  onTap: () {
                    bLocCreateSeedPhrase
                        .reloadListTitleBox(listTitle[index].title);
                    bLocCreateSeedPhrase.listTitle3.removeAt(index);
                    bLocCreateSeedPhrase.reloadListTitle();
                  },
                  child: ItemSeedPhrase(
                    title: '${index + 1}. ${listTitle[index].title}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
