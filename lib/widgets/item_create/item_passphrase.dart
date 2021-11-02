import 'dart:ui';

import 'package:Dfy/domain/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemPassPhrase extends StatefulWidget {
  final List<Item> listTitle;

  const ItemPassPhrase({Key? key, required this.listTitle}) : super(key: key);

  @override
  _ItemPassPhraseState createState() => _ItemPassPhraseState();
}

class _ItemPassPhraseState extends State<ItemPassPhrase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x80A7A7A7),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 16, left: 13, right: 13),
      height: 222.h,
      width: 323.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your seed passphrase',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  print('copy');
                },
                child: Image.asset(
                  'assets/images/copy.png',
                  height: 17,
                  width: 17,
                ),
              )
            ],
          ),
          SizedBox(
            height: 21.h,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 12,
            children: List<Widget>.generate(
              widget.listTitle.length,
              (int index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 0.5.w),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    '${index + 1}. ${widget.listTitle[index].title}',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
