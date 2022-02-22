import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/bloc/connect_wallet_dialog_cubit.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_email_dialog.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/enter_email_screen.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/stream/stream_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletDialogWhenLoggedCore extends StatefulWidget {
  const WalletDialogWhenLoggedCore({
    Key? key,
    required this.cubit,
    required this.wallet,
    required this.isRequireLoginEmail,
    this.navigationTo,
    this.settings,
  }) : super(key: key);
  final ConnectWalletDialogCubit cubit;
  final Wallet wallet;
  final Widget? navigationTo;
  final bool isRequireLoginEmail;
  final RouteSettings? settings;

  @override
  State<WalletDialogWhenLoggedCore> createState() =>
      _WalletDialogWhenLoggedCoreState();
}

class _WalletDialogWhenLoggedCoreState
    extends State<WalletDialogWhenLoggedCore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamListenerCustom<String>(
      listen: (value) async {
        if (value.isEmpty) {
          showErrDialog(
            context: context,
            title: S.current.notify,
            content: S.current.something_went_wrong,
          );
          return;
        }
        final nav = Navigator.of(context);
        showLoading(context);
        final bool checkSuccess = await widget.cubit.loginAndSaveInfo(
          walletAddress: widget.cubit.wallet?.address ?? '',
          signature: value,
        );
        hideLoading(context);
        if (checkSuccess) {
          final data = PrefsService.getUserProfile();
          final userProfile = userProfileFromJson(data);
          final String email = userProfile.email ?? '';
          if (email.isNotEmpty) {
            if (widget.navigationTo != null) {
              unawaited(
                nav.pushReplacement(
                  MaterialPageRoute(
                    settings: widget.settings,
                    builder: (context) => widget.navigationTo!,
                  ),
                ),
              );
              return;
            } else {
              nav.pop();
              return;
            }
          }
          if (!widget.isRequireLoginEmail) {
            //không yêu cầu login email:
            final bool isNeedShowDialog =
                PrefsService.getOptionShowDialogConnectEmail();
            if (isNeedShowDialog) {
              if (email.isEmpty) {
                nav.pop();
                unawaited(
                  showDialog(
                    context: context,
                    builder: (context) => ConnectEmailDialog(
                      settings: widget.settings,
                      navigationTo: widget.navigationTo,
                    ),
                  ),
                );
              }
            } else {
              if (widget.navigationTo != null) {
                unawaited(
                  nav.pushReplacement(
                    MaterialPageRoute(
                      settings: widget.settings,
                      builder: (context) => widget.navigationTo!,
                    ),
                  ),
                );
              } else {
                nav.pop();
              }
            }
          } else {
            await nav.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EnterEmail(),
              ),
            );
          }
        } else {
          unawaited(
            nav.pushReplacement(
              MaterialPageRoute(
                builder: (context) => BaseFail(
                  title: S.current.login,
                  content: S.current.something_went_wrong,
                  onTapBtn: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        }
      },
      stream: widget.cubit.signatureStream,
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
                            addressWallet: widget.wallet.address ?? '',
                            nameWallet: widget.wallet.name ?? '',
                            nameToken: 'BNB',
                            imgWallet: '${ImageAssets.image_avatar}'
                                '${widget.cubit.randomAvatar()}'
                                '.png',
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      child: GestureDetector(
                        onTap: () {
                          widget.cubit.getSignature(
                            walletAddress: widget.wallet.address ?? '',
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
              stream: widget.cubit.balanceStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data ?? 0} $nameToken',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  );
                } else {
                  return Text(
                    S.current.loading_text,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  );
                }
              },
            ),
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
