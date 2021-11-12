import 'dart:ui';

import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveToken extends StatelessWidget {
  const RemoveToken({
    Key? key, required this.cubit, required this.index,
  }) : super(key: key);
  final WalletCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
      child: Center(
        child: SizedBox(
          height: 355.h,
          width: 312.w,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 77.h,
                child: Center(
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
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 93,
                                ),
                                Container(
                                  child: Text(
                                    S.current.Are_you_sure_token,
                                    style: textNormal(
                                      null,
                                      20.sp,
                                    ).copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                spaceH12,
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 34.w),
                                  child: Text(
                                    S.current.This_will_also,
                                    style: textNormal(
                                      null,
                                      12.sp,
                                    ).copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                spaceH24,
                              ],
                            ),
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
                                          style:
                                              textNormal(null, 20.sp).copyWith(
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
                                          cubit.listToken.removeAt(index);
                                          cubit.getListTokenItem();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          S.current.Remove,
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
              Positioned(
                bottom: 193.h,
                child: SizedBox(
                  width: 162.w,
                  height: 162.h,
                  child: Image.asset(
                    url_ic_delete,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
