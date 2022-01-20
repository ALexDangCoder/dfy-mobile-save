import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/bloc/connect_wallet_dialog_cubit.dart';
import 'package:Dfy/presentation/market_place/login/ui/stream_consumer.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletDialogWhenLoggedCore extends StatefulWidget {
  const WalletDialogWhenLoggedCore({
    Key? key,
    required this.cubit,
    required this.wallet,
    required this.balance,
  }) : super(key: key);
  final ConnectWalletDialogCubit cubit;
  final Wallet wallet;
  final double balance;

  @override
  State<WalletDialogWhenLoggedCore> createState() => _WalletDialogWhenLoggedCoreState();
}

class _WalletDialogWhenLoggedCoreState extends State<WalletDialogWhenLoggedCore> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamConsumerCustom<String>(
      listen: (value) {
        widget.cubit.loginAndSaveInfo(
          walletAddress: widget.cubit.wallet?.address ?? '',
          signature: value,
        );
      },
      stream: widget.cubit.signatureStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {},
              child: Center(
                child: SizedBox(
                  height: 250.h,
                  width: 312.w,
                  child: Container(
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
                                moneyWallet: widget.balance,
                                nameToken: 'BNB',
                                imgWallet:
                                '${ImageAssets.image_avatar}${widget.cubit.randomAvatar()}'
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
      },
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
            Text(
              '$moneyWallet $nameToken',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
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
