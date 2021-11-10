import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_token.dart';
import 'package:Dfy/presentation/select_acc/bloc/select_acc_bloc.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/import.dart';
import 'package:Dfy/presentation/wallet/ui/nft_item.dart';
import 'package:Dfy/presentation/wallet/ui/popup_copied.dart';
import 'package:Dfy/presentation/wallet/ui/token_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/change_wallet_name.dart';
import 'package:Dfy/widgets/dialog_remove/choose_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import 'hero.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final WalletCubit _cubit = WalletCubit();
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _cubit.formatAddress(_cubit.addressWallet);
    _tabController = TabController(length: 2, vsync: this);
    fToast = FToast();
    fToast.init(context);
    trustWalletChannel
        .setMethodCallHandler(_cubit.nativeMethodCallBackTrustWallet);
    _cubit.getListNFT(
      _cubit.addressWallet,
      password: 'aaa',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: 375.w,
            height: 812.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: listBackgroundColor,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 44.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: SizedBox(
                    height: 54.h,
                    width: 323.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                          ),
                          child: Column(
                            children: [
                              Text(
                                S.current.wallet,
                                style: textNormalCustom(
                                  Colors.white,
                                  20.sp,
                                  FontWeight.w700,
                                ),
                              ),
                              Text(
                                S.current.smart_chain,
                                style: textNormalCustom(
                                  Colors.grey.shade400,
                                  14.sp,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Divider(
                  height: 1.h,
                  color: const Color(0xFF4b4a60),
                ),
                SizedBox(
                  height: 24.h,
                ),
                header(),
                SizedBox(
                  height: 24.h,
                ),
                SizedBox(
                  height: 44.h,
                  width: 230.w,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF9997FF),
                    indicatorColor: const Color(0xFF6F6FC5),
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: [
                      Tab(
                        text: S.current.token,
                      ),
                      Tab(
                        text: S.current.nft,
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SizedBox(
                        height: 409.h,
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return TokenItem(
                                    symbolUrl: ImageAssets.symbol,
                                    amount: '1200000',
                                    nameToken: 'DFY',
                                    price: '$index',
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: ImportToken(
                                  title: S.current.import_token,
                                  icon: ImageAssets.icImport,
                                ),
                              ),
                              SizedBox(
                                height: 102.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 409.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return const NFTItem(
                                    symbolUrl: ImageAssets.symbol,
                                    nameNFT: 'DeFi For You',
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  // showImportToken(context, ImportTokenNftBloc());
                                },
                                child: ImportToken(
                                  title: S.current.import_NFT,
                                  icon: ImageAssets.icImport,
                                ),
                              ),
                              ImportToken(
                                title: S.current.create_NFT,
                                icon: ImageAssets.icAdd,
                              ),
                              SizedBox(
                                height: 102.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 125.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    showSelectAcc(context, SelectAccBloc());
                  },
                  child: CircleAvatar(
                    radius: 27.sp,
                    child: const Image(
                      image: AssetImage(ImageAssets.symbol),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 37.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) {
                            return const ChooseAcc();
                          },
                          isNonBackground: false,
                        ),
                      );
                    },
                    child: Text(
                      'Nguyen Van Hung',
                      style: textNormalCustom(
                        Colors.white,
                        24.sp,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) {
                            return const ChangeWalletName();
                          },
                          isNonBackground: false,
                        ),
                      );
                    },
                    child: ImageIcon(
                      const AssetImage(ImageAssets.icEdit),
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: Text(
                  '\$ 3,800',
                  style: textNormalCustom(
                    const Color(0xFFE4AC1A),
                    20.sp,
                    FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 129.w,
          ),
          child: Row(
            children: [
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(
                    ClipboardData(text: _cubit.addressWallet),
                  ).then((_) {
                    fToast.showToast(
                      child: const Copied(),
                      gravity: ToastGravity.CENTER,
                      toastDuration: const Duration(
                        seconds: 2,
                      ),
                    );
                  });
                },
                child: Container(
                  height: 36.h,
                  width: 116.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF585769),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _cubit.formatAddressWallet,
                      style: textNormalCustom(
                        Colors.white,
                        16.sp,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {

                },
                icon: const ImageIcon(
                  AssetImage(ImageAssets.code),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
