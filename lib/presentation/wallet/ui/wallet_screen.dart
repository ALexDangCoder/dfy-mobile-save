import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/bts_receive_dfy.dart';
import 'package:Dfy/presentation/create_wallet_first_time/wallet_add_feat_seedpharse/ui/add_wallet_ft_seedpharse.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/setting_wallet.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/createNFT.dart';
import 'package:Dfy/presentation/wallet/ui/import.dart';
import 'package:Dfy/presentation/wallet/ui/nft_item.dart';
import 'package:Dfy/presentation/wallet/ui/popup_copied.dart';
import 'package:Dfy/presentation/wallet/ui/token_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/change_wallet_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'hero.dart';

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
  final WalletCubit cubit = WalletCubit();
  late FToast fToast;
  final changeName = TextEditingController();
  final formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');

  @override
  void initState() {
    super.initState();
    cubit.addressWalletCore =
        widget.wallet?.address ?? '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf';

    cubit.addressWallet.sink.add(
      widget.wallet?.address ?? '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf',
    );
    cubit.walletName.sink.add(widget.wallet?.name ?? 'Nguyen Van Hung');
    cubit.walletName.stream.listen((event) {
      changeName.text = event;
    });
    _tabController = TabController(length: 2, vsync: this);
    fToast = FToast();
    fToast.init(context);
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getListNFT(
      cubit.addressWallet.value,
      password: 'aaa',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 1) {
      return Scaffold(
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
                        icon: const Icon(
                          Icons.menu,
                          size: 24,
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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return SettingWallet(
                                cubitSetting: SettingWalletCubit(),
                                cubit: cubit,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.settings_outlined,
                          size: 24,
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
                  labelStyle: const TextStyle(
                    fontSize: 14,
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
                            StreamBuilder(
                              stream: cubit.listTokenStream,
                              builder: (
                                context,
                                AsyncSnapshot<List<TokenModel>> snapshot,
                              ) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:snapshot.data?.length ??0,
                                  itemBuilder: (context, index) {
                                    return TokenItem(
                                      index: index,
                                      bloc: cubit,
                                      symbolUrl:
                                          snapshot.data?[index].iconToken ??
                                              'assets/images/Ellipse 39.png',
                                      amount: snapshot.data?[index].amountToken
                                              .toString() ??
                                          '',
                                      nameToken: snapshot
                                              .data?[index].nameTokenSymbol ??
                                          '',
                                      price: snapshot.data?[index].price
                                              .toString() ??
                                          '',
                                    );
                                  },
                                );
                              },
                            ),
                            ImportToken(
                              walletCubit: cubit,
                              title: S.current.import_token,
                              icon: ImageAssets.ic_import2,
                              keyRouter: 1,
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
                            StreamBuilder(
                              stream: cubit.listNFTStream,
                              builder: (
                                context,
                                AsyncSnapshot<List<TokenModel>> snapshot,
                              ) {
                                if (snapshot.hasData) {
                                  return SafeArea(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        return NFTItem(
                                          index: index,
                                          bloc: cubit,
                                          symbolUrl:
                                              snapshot.data?[index].iconToken ??
                                                  '',
                                          nameNFT:
                                              snapshot.data?[index].nameToken ??
                                                  '',
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            ImportToken(
                              walletCubit: cubit,
                              title: S.current.import_nft,
                              icon: ImageAssets.ic_import2,
                              keyRouter: 2,
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
          height: 125.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    showSelectAcc(context, cubit, TypeScreen2.detail);
                  },
                  child: const CircleAvatar(
                    radius: 27,
                    child: Image(
                      image: AssetImage(ImageAssets.ic_symbol),
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
                        snapshot.data ?? '',
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
                    child: const ImageIcon(
                      AssetImage(ImageAssets.ic_edit),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: StreamBuilder(
                    stream: cubit.totalBalance,
                    builder: (context, AsyncSnapshot<double> snapshot) {
                      return Text(
                        formatUSD.format(
                          snapshot.data ??
                              cubit.total(cubit.getListTokenModel.value),
                        ),
                        style: textNormalCustom(
                          const Color(0xFFE4AC1A),
                          20.sp,
                          FontWeight.w600,
                        ),
                      );
                    }),
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
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Receive(
                      walletAddress: widget.wallet?.address ??
                          '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf',
                      type: TokenType.QR,
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
