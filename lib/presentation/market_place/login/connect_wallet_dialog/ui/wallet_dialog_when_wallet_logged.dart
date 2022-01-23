import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/bloc/connect_wallet_dialog_cubit.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/widgets/stream_consumer/stream_listener.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletDialogWhenLoggedCore extends StatelessWidget {
  const WalletDialogWhenLoggedCore({
    Key? key,
    required this.cubit,
    required this.wallet,
    required this.balance,
    required this.navigationTo,
  }) : super(key: key);
  final ConnectWalletDialogCubit cubit;
  final Wallet wallet;
  final double balance;
  final Widget navigationTo;

  @override
  Widget build(BuildContext context) {
    return StreamListenerCustom<String>(
      listen: (value) async {
        final nav = Navigator.of(context);
        showLoading(context);
        await cubit.loginAndSaveInfo(
          walletAddress: cubit.wallet?.address ?? '',
          signature: value,
        );
        hideLoading(context);
        unawaited(
          nav.pushReplacement(
            MaterialPageRoute(builder: (context) => navigationTo),
          ),
        );
      },
      stream: cubit.signatureStream,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {},
            child: Center(
              child: SizedBox(
                height: 250.h,
                width: 312.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        left: 20.w,
                      ),
                      height: 188.h,
                      width: 312.w,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().bgTranSubmit(),
                        borderRadius: BorderRadius.circular(
                          36.r,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          txtConnectWallet(),
                          spaceH27,
                          informationWallet(
                            addressWallet: wallet.address ?? '',
                            nameWallet: wallet.name ?? '',
                            moneyWallet: balance,
                            nameToken: 'BNB',
                            imgWallet:
                                '${ImageAssets.image_avatar}${cubit.randomAvatar()}'
                                '.png',
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      child: GestureDetector(
                        onTap: () {
                          cubit.getSignature(
                            walletAddress: wallet.address ?? '',
                            context: context,
                          );
                        },
                        child: Container(
                          height: 64.h,
                          width: 210.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppTheme.getInstance().colorFab(),
                            ),
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                          child: Center(
                            child: Text(
                              S.current.connect,
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                20,
                                FontWeight.w700,
                              ),
                            ),
                          ),
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

  Row informationWallet({
    required String nameToken,
    required String nameWallet,
    required String addressWallet,
    required double moneyWallet,
    required String imgWallet,
  }) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                imgWallet,
              ),
            ),
          ),
          height: 40,
          width: 40,
        ),
        spaceW8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  (nameWallet.length > 12)
                      ? nameWallet.formatStringTooLong()
                      : nameWallet,
                  overflow: TextOverflow.ellipsis,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w700,
                  ),
                ),
                spaceW8,
                Text(
                  addressWallet.formatAddressDialog(),
                  overflow: TextOverflow.ellipsis,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteOpacityDot5(),
                    14,
                    FontWeight.w400,
                  ),
                )
              ],
            ),
            spaceH2,
            StreamBuilder<Object>(
                stream: cubit.balanceStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data ?? 0} $nameToken',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }

  Text txtConnectWallet() {
    return Text(
      S.current.connect_wallet,
      style: textNormalCustom(
        AppTheme.getInstance().whiteColor(),
        20,
        FontWeight.w700,
      ),
    );
  }
}
