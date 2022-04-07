import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterSuccessfullyStep extends StatelessWidget {
  const RegisterSuccessfullyStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: AppTheme.getInstance().blackColor(),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 812.h,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.h),
                    topRight: Radius.circular(30.h),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    spaceH16,
                    SizedBox(
                      width: 343.w,
                      child: Text(
                        S.current.register_successfully,
                        style: textNormalCustom(
                          null,
                          20.sp,
                          FontWeight.w700,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    spaceH20,
                    line, spaceH24,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 343.w,
                          padding: EdgeInsets.only(
                            top: 16.h,
                            left: 16.h,
                            right: 16.h,
                            bottom: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().colorTextReset(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.identity_verification,
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                  FontWeight.w700,
                                ),
                              ),
                              spaceH7,
                              Text(
                                S.current.verification_is_required,
                                style: textNormalCustom(
                                  AppTheme.getInstance()
                                      .whiteWithOpacitySevenZero(),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH13,
                              GestureDetector(
                                onTap: () {
                                  //todo

                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${S.current.verify_now}  ➞',
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      12,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          ImageAssets.img_verify_now,
                        ),
                      ],
                    ),
                    spaceH32,
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 343.w,
                          padding: EdgeInsets.only(
                            top: 16.h,
                            left: 16.h,
                            right: 16.h,
                            bottom: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().colorTextReset(),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.current.create_first_package,
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                  FontWeight.w700,
                                ),
                              ),
                              spaceH7,
                              Text(
                                S.current.create_your_first,
                                style: textNormalCustom(
                                  AppTheme.getInstance()
                                      .whiteWithOpacitySevenZero(),
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                              spaceH13,
                              GestureDetector(
                                onTap: () {
                                  //todo
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${S.current.create_now_pawn}  ➞',
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueColor(),
                                      12,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          ImageAssets.img_verify_now,
                        ),
                      ],
                    ),
                    //todo
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(
                bottom: 38.h,
              ),
              color: AppTheme.getInstance().bgBtsColor(),
              child: GestureDetector(
                onTap: () async {
                  //todo
                },
                child: Container(
                  color: AppTheme.getInstance().bgBtsColor(),
                  child: ButtonGold(
                    isEnable: true,
                    title: S.current.skip_this_step,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
