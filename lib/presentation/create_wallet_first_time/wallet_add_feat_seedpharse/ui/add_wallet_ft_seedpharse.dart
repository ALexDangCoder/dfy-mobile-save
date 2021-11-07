import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWalletFtSeedPhrase extends StatefulWidget {
  const AddWalletFtSeedPhrase({Key? key}) : super(key: key);

  @override
  _AddWalletFtSeedPhraseState createState() => _AddWalletFtSeedPhraseState();
}

class _AddWalletFtSeedPhraseState extends State<AddWalletFtSeedPhrase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: 812.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppTheme.getInstance().listColorAddWalletSeedPhrase(),
          ),
        ),
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 14.h,
            ),
            Divider(
              thickness: 1,
              color: AppTheme.getInstance().divideColor(),
            ),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    btnAddWallet(),
                    SizedBox(height: 39.h),
                    GestureDetector(
                      onTap: () {},
                      child: btnImportSeedPharse(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox btnImportSeedPharse() {
    return SizedBox(
      width: 323.w,
      height: 25.h,
      child: Center(
        child: Text(
          S.current.import_seed,
          style: textNormal(
            AppTheme.getInstance().activeColor(),
            20.sp,
          ).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Container btnAddWallet() {
    return Container(
      width: 298.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(22.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().activeColor(),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 131.w,
          height: 28.h,
          child: Center(
            child: Row(
              children: [
                Image.asset(ImageAssets.add_wallet),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Text(
                    S.current.add_wallet,
                    style: textNormal(
                      AppTheme.getInstance().activeColor(),
                      20.sp,
                    ).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(228, 172, 26, 1),
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

  Padding header() {
    return Padding(
      padding: EdgeInsets.only(
        top: 44.h,
        left: 26.w,
        right: 26.w,
        bottom: 14.h,
      ),
      child: SizedBox(
        width: 323.w,
        height: 54.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(ImageAssets.ic_menu),
            ),
            Column(
              children: [
                Text(
                  S.current.wallet,
                  style: textNormal(
                    AppTheme.getInstance().whiteWithOpacity(),
                    20.sp,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  S.current.smart_chain,
                  style: textNormal(
                    AppTheme.getInstance().whiteWithOpacity(),
                    14.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(ImageAssets.ic_notify),
            )
          ],
        ),
      ),
    );
  }
}
