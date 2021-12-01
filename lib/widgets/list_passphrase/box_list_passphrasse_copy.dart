import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:Dfy/widgets/toast/toast_copy.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxListPassWordPhraseCopy extends StatelessWidget {
  final List<String> listTitle;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const BoxListPassWordPhraseCopy({
    Key? key,
    required this.listTitle,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w, left: 16.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(top: 16.h, left: 13.w, right: 13.w),
      height: 222.h,
      width: 343.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.your_seed,
                style: textNormal(
               Colors.white,
                  16.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(bLocCreateSeedPhrase.passPhrase);
                  toast_copy();
                },
                child: Image.asset(
                  ImageAssets.ic_copy,
                  height: 17.67.h,
                  width: 19.14.w,
                  color: AppTheme.getInstance().fillColor(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 21.h,
          ),
          Wrap(
            spacing: 5.w,
            runSpacing: 12.h,
            children: List<Widget>.generate(
              listTitle.length,
              (int index) {
                return ItemSeedPhrase(
                  title: ' ${listTitle[index]}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
