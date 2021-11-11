import 'dart:ui';

import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_rect_tween.dart';

class ChooseAcc extends StatelessWidget {
  final PrivateKeySeedPhraseBloc bloc;
  const ChooseAcc({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
      child: Center(
        child: SizedBox(
          height: 313.h,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24.h, left: 26.w),
                        child: Text(
                          S.current.choose_acc,
                          style: textNormal(Colors.white, 20.sp).copyWith(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 26.w, top: 27.h),
                          child: Image.asset(
                            url_ic_close,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH12,
                  SizedBox(
                    height: 246.h,
                    child: ListView.builder(
                      itemCount: bloc.listWallet.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            bloc.index.sink.add(index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 312.w,
                            height: 82.h,
                              decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                spaceW16,
                                Image.asset(
                                  bloc.listWallet[index].urlImage ?? '',
                                ),
                                spaceW8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      bloc.listWallet[index].walletName ?? '',
                                      style: textNormal(Colors.white, 20.sp)
                                          .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Text(
                                      bloc.formatText(
                                        bloc.listWallet[index].walletAddress ??
                                            '',
                                      ),
                                      style: textNormal(
                                        Colors.white.withOpacity(0.5),
                                        16.sp,
                                      ).copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
