import 'dart:ui';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseAcc extends StatelessWidget {
  final ConfirmPwPrvKeySeedpharseCubit bloc;
  final List<Wallet> listWalletCore;
  final String walletAddress;

  const ChooseAcc({
    Key? key,
    required this.bloc,
    required this.listWalletCore,
    required this.walletAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
      child: Center(
        child: SizedBox(
          height: 313.h,
          width: 311.w,
          child: SafeArea(
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
                clipBehavior: Clip.hardEdge,
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
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              20,
                            ).copyWith(
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
                            child: SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Image.asset(
                                ImageAssets.ic_close,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceH12,
                    Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listWalletCore.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                bloc.sendPrivateKey(index);
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 311.w,
                                    height: 82.h,
                                    child: Row(
                                      children: [
                                        spaceW16,
                                        Container(
                                          height: 44.h,
                                          width: 44.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                '${ImageAssets.image_avatar}${bloc.randomAvatar()}'
                                                '.png',
                                              ),
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        spaceW8,
                                        SizedBox(
                                          width: 185.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                listWalletCore[index].name ??
                                                    '',
                                                style: textNormal(
                                                  AppTheme.getInstance()
                                                      .whiteColor(),
                                                  20,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                listWalletCore[index]
                                                        .address
                                                        ?.formatAddressWalletConfirm() ??
                                                    '',
                                                style: textNormal(
                                                  Colors.white.withOpacity(0.5),
                                                  16,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 16.w,
                                          ),
                                          child: walletAddress ==
                                                  listWalletCore[index].address
                                              ? Image.asset(
                                                  ImageAssets.ic_selected,
                                                  width: 24.w,
                                                  height: 24.h,
                                                )
                                              : SizedBox(
                                                  width: 24.w,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: index + 1 == listWalletCore.length
                                        ? null
                                        : line,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
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
