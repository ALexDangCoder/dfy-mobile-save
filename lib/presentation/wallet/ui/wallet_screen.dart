import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/collection_nft_info.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/wallet_add_feat_seedpharse/ui/add_wallet_ft_seedpharse.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/setting_wallet.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/createNFT.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/presentation/wallet/ui/import.dart';
import 'package:Dfy/presentation/wallet/ui/nft_item.dart';
import 'package:Dfy/presentation/wallet/ui/popup_copied.dart';
import 'package:Dfy/presentation/wallet/ui/token_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/change_wallet_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
    required this.index,
    this.wallet,
  }) : super(key: key);
  final int index;
  final Wallet? wallet;

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final WalletCubit cubit;
  late FToast fToast;
  final changeName = TextEditingController();
  final formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');

  @override
  void initState() {
    super.initState();
    cubit = WalletCubit();
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    if (widget.index == 1) {
      cubit.walletName.sink.add(widget.wallet?.name ?? cubit.nameWallet);
      cubit.addressWallet
          .add(widget.wallet?.address ?? cubit.addressWalletCore);
      cubit.walletName.stream.listen((event) {
        changeName.text = event;
      });
      _tabController = TabController(length: 2, vsync: this);
      fToast = FToast();
      fToast.init(context);
      cubit.getListWallets();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String addressWallet = cubit.addressWalletCore;
    if (widget.index == 1) {
      return BlocListener<WalletCubit, WalletState>(
        bloc: cubit,
        listener: (context, state) {
          if (state == NavigatorFirst()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(
                  index: 3,
                ),
              ),
            );
          }
        },
        child: Scaffold(
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
                    width: 323.w,
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
                                  20,
                                  FontWeight.w700,
                                ),
                              ),
                              Text(
                                S.current.smart_chain,
                                style: textNormalCustom(
                                  Colors.grey.shade400,
                                  14,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return SettingWallet(
                                    cubitSetting: SettingWalletCubit(),
                                    cubit: cubit,
                                  );
                                },
                              ),
                            );
                          },
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
                    labelStyle: textNormalCustom(
                      Colors.grey.shade400,
                      14,
                      FontWeight.w600,
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
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await cubit.getBalanceOFToken(
                              cubit.listTokenFromWalletCore,
                            );
                            cubit.getExchangeRateFromServer(
                              cubit.listTokenFromWalletCore,
                            );
                            cubit.totalBalance.add(
                              cubit.total(cubit.listTokenFromWalletCore),
                            );
                            cubit.listTokenStream
                                .add(cubit.listTokenFromWalletCore);
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                StreamBuilder(
                                  stream: cubit.listTokenStream,
                                  builder: (
                                    context,
                                    AsyncSnapshot<List<ModelToken>> snapshot,
                                  ) {
                                    if (snapshot.data?.isNotEmpty ?? true) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return TokenItem(
                                            walletAddress:
                                                cubit.addressWalletCore,
                                            index: index,
                                            bloc: cubit,
                                            modelToken: snapshot.data![index],
                                          );
                                        },
                                      );
                                    }
                                    return SizedBox(
                                      height: 100.h,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3.r,
                                          color: AppTheme.getInstance()
                                              .whiteColor(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ImportToken(
                                  title: S.current.import_token,
                                  icon: ImageAssets.ic_import2,
                                  keyRouter: 1,
                                  addressWallet: addressWallet,
                                  cubit: cubit,
                                ),
                                SizedBox(
                                  height: 102.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 409.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StreamBuilder<List<CollectionNft>>(
                                stream: cubit.listNFTStream,
                                builder: (
                                  context,
                                  AsyncSnapshot<List<CollectionNft>> snapshot,
                                ) {
                                  if (snapshot.data?.isNotEmpty ?? true) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return NFTItem(
                                          walletAddress:
                                              cubit.addressWalletCore,
                                          index: index,
                                          bloc: cubit,
                                          collectionNft: snapshot.data![index],
                                        );
                                      },
                                    );
                                  } else if (snapshot.data?.isEmpty ?? true) {
                                    return const SizedBox();
                                  }
                                  return SizedBox(
                                    height: 100.h,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.r,
                                        color:
                                            AppTheme.getInstance().whiteColor(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              ImportToken(
                                title: S.current.import_nft,
                                icon: ImageAssets.ic_import2,
                                keyRouter: 2,
                                addressWallet: addressWallet,
                                cubit: cubit,
                              ),
                              CreateNFT(
                                title: S.current.create_nft,
                                icon: ImageAssets.ic_add,
                                walletCubit: cubit,
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
      );
    } else if (widget.index == 2) {
      return LoginScreen(
        walletCubit: cubit,
      );
    } else {
      return const AddWalletFtSeedPharse();
    }
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectAcc(
                            bloc: cubit,
                            typeScreen2: TypeScreen2.detail,
                          );
                        },
                      ),
                    ).whenComplete(
                      () async {
                        cubit.listTokenStream.add([]);
                        await cubit.getListWallets();
                        cubit.getListAcc();
                      },
                    );
                  },
                  child: Container(
                    width: 54.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          '${ImageAssets.image_avatar}${cubit.randomAvatar()}'
                          '.png',
                        ),
                      ),
                      shape: BoxShape.circle,
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
                  StreamBuilder(
                    stream: cubit.walletName,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return Text(
                        snapshot.data ?? cubit.nameWallet,
                        style: textNormalCustom(
                          Colors.white,
                          24,
                          FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 13.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) {
                            return ChangeWalletName(
                              textEditingController: changeName,
                              bloc: cubit,
                            );
                          },
                          isNonBackground: false,
                        ),
                      );
                    },
                    child: ImageIcon(
                      const AssetImage(ImageAssets.ic_edit),
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
                child: StreamBuilder<double>(
                  stream: cubit.totalBalance,
                  initialData: 0.0,
                  builder: (context, AsyncSnapshot<double> snapshot) {
                    return Text(
                      formatUSD.format(
                        snapshot.data ?? 0,
                      ),
                      style: textNormalCustom(
                        const Color(0xFFE4AC1A),
                        20,
                        FontWeight.w600,
                      ),
                    );
                  },
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
                    ClipboardData(text: cubit.addressWalletCore),
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
                  child: StreamBuilder(
                    stream: cubit.addressWallet,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return Center(
                        child: Text(
                          cubit.formatAddress(
                            snapshot.data ?? cubit.addressWalletCore,
                          ),
                          style: textNormalCustom(
                            Colors.white,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Receive(
                        walletAddress:
                            widget.wallet?.address ?? cubit.addressWalletCore,
                        type: TokenType.QR,
                      ),
                    ),
                  );
                },
                icon: const ImageIcon(
                  AssetImage(ImageAssets.ic_qr_code),
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
