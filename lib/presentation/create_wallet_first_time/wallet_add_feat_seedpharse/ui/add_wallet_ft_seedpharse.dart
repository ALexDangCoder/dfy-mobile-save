import 'package:Dfy/presentation/create_wallet_first_time/setup_password/ui/setup_password.dart';
import 'package:Dfy/presentation/restore_bts/ui/restore_bts.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddWalletFtSeedPharse extends StatefulWidget {
  const AddWalletFtSeedPharse({Key? key}) : super(key: key);

  @override
  _AddWalletFtSeedPharseState createState() => _AddWalletFtSeedPharseState();
}

class _AddWalletFtSeedPharseState extends State<AddWalletFtSeedPharse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375.w,
        height: 812.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(60, 59, 84, 1),
              Color.fromRGBO(23, 21, 39, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 14.h,
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(255, 255, 255, 0.1),
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
                      child: btnImportSeedPhrase(),
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

  Widget btnImportSeedPhrase() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return const RestoreBTS();
          },
          isScrollControlled: true,
        );
      },
      child: SizedBox(
        width: 323.w,
        height: 25.h,
        child: Center(
          child: Text(
            'Import secret seedphrase',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(228, 172, 26, 1),
            ),
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
          color: const Color.fromRGBO(228, 172, 26, 1),
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 131.w,
          height: 28.h,
          child: Center(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const SetupPassWord();
                  },
                  isScrollControlled: true,
                );
              },
              child: Row(
                children: [
                  Image.asset(ImageAssets.addsWallet),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      'Add Wallet',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: const Color.fromRGBO(228, 172, 26, 1),
                      ),
                    ),
                  ),
                ],
              ),
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
              icon: Image.asset(ImageAssets.menu),
            ),
            Column(
              children: [
                Text(
                  'Wallet',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Smart chain',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(189, 189, 189, 1),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(ImageAssets.notification),
            )
          ],
        ),
      ),
    );
  }
}
