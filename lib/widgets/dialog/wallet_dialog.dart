import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///how to use
///         showDialog(
///              context: context,
///              builder: (_) => Dialog(
///                 backgroundColor: Colors.transparent,
///                 child: WalletDialogLogin(
///                   callback: () {},
///                 ),
///               ),
///             );

class WalletDialogLogin extends StatelessWidget {
  const WalletDialogLogin({
    Key? key,
    required this.callback,
    required this.nameWallet,
    required this.addressWallet,
    required this.moneyWallet,
    required this.shortNameToken,
    required this.imgWallet,
  }) : super(key: key);
  final Function()? callback;
  final String addressWallet;
  final String nameWallet;
  final double moneyWallet;
  final String shortNameToken;
  final String imgWallet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              children: [
                txtConnectWallet(),
                spaceH27,
                informationWallet(
                  addressWallet: addressWallet,
                  nameWallet: nameWallet,
                  moneyWallet: moneyWallet,
                  nameToken: shortNameToken,
                  imgWallet: imgWallet,
                )
              ],
            ),
          ),
          Positioned(
            top: 180.h,
            child: GestureDetector(
              onTap: callback,
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
        circularImage(
          imgWallet,
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
