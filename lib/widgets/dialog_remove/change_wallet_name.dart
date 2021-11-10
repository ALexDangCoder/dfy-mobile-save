import 'dart:ui';

import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_rect_tween.dart';

class ChangeWalletName extends StatelessWidget {
  const ChangeWalletName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
      child: Center(
        child: SizedBox(
          height: 225.h,
          width: 312.w,
          child: Hero(
            tag: '',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Material(
              color: const Color(0xff585782),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              child: SizedBox(
                width: 312.w,
                height: 278.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.w, left: 20.w, bottom: 24.h),
                      child: Text(
                        S.current.Enter_name,
                        style: textNormal(Colors.white, 20.sp).copyWith(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 271.w,
                        height: 64.h,
                        padding: EdgeInsets.only(right: 15.w, left: 15.w),
                        decoration:  BoxDecoration(
                          color: const Color(0xff32324c).withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                              child: Container(
                                padding: EdgeInsets.only(right: 5.w),
                                child: TextFormField(
                                  maxLength: 20,
                                  //controller: nameWallet,
                                  cursorColor: Colors.white,
                                  style: textNormal(
                                    Colors.white54,
                                    16.sp,
                                  ),
                                  onChanged: (value) {
                                    //widget.blocCreateSeedPhrase.isButton();
                                  },
                                  decoration: InputDecoration(
                                    hintText: S.current.name_wallet,
                                    hintStyle: textNormal(
                                      Colors.white54,
                                      16.sp,
                                    ),
                                    counterText: '',
                                    border: InputBorder.none,
                                  ),
                                  // onFieldSubmitted: ,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // widget.blocCreateSeedPhrase.nameWallet.sink
                                //     .add('');
                                // nameWallet.text = '';
                                // widget.blocCreateSeedPhrase.isButton();
                                // setState(() {});
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
                    ),
                    spaceH24,
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  S.current.cancel,
                                  style: textNormal(null, 20.sp).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const VerticalDivider(),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  S.current.Confirm,
                                  style: textNormal(
                                    const Color(0xffE4AC1A),
                                    20.sp,
                                  ).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
