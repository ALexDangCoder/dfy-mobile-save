import 'dart:ui';
import 'package:Dfy/widgets/item_seedphrase/item_seedphrase.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxListPassWordPhraseCopy extends StatelessWidget {
  final List<String> listTitle;

  const BoxListPassWordPhraseCopy({Key? key, required this.listTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: EdgeInsets.only(top: 16.h, left: 13.w, right: 13.w),
      height: 222.h,
      width: 323.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your seed phrase',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(listTitle.toString());
                },
                child: Image.asset(
                  'assets/images/copy.png',
                  height: 17.67.h,
                  width: 19.14.w,
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
