import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveToken extends StatelessWidget {
  const RemoveToken({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);
  final WalletCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 400.h,
              maxWidth: 312.w,
            ),
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
                        color: AppTheme.getInstance().selectDialogColor(),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.r),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 312.w,
                            minHeight: 278.h,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 93.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 34.w),
                                child: Text(
                                  S.current.are_you_sure_token,
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
                                padding: EdgeInsets.symmetric(horizontal: 34.w),
                                child: Text(
                                  S.current.this_will_also,
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
                              SizedBox(
                                height: 64.h,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppTheme.getInstance()
                                            .divideColor(),
                                        width: 1.w,
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
                                          child: Container(
                                            height: 64.h,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: AppTheme.getInstance()
                                                      .divideColor(),
                                                  width: 1.h,
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                S.current.cancel,
                                                style: textNormal(null, 20.sp)
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            cubit.listTokenDetailScreen
                                                .removeAt(index);
                                            cubit.totalBalance.add(
                                              cubit.total(
                                                cubit.listTokenStream.value,
                                              ),
                                            );
                                            cubit.getListTokenItemRemove();
                                            Navigator.pop(context);
                                          },
                                          child: SizedBox(
                                            height: 64.h,
                                            child: Center(
                                              child: Text(
                                                S.current.remove,
                                                style: textNormal(
                                                  AppTheme.getInstance()
                                                      .fillColor(),
                                                  20.sp,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
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
                  bottom: 238.h,
                  child: SizedBox(
                    width: 162.w,
                    height: 162.h,
                    child: Image.asset(
                      ImageAssets.img_delete,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
