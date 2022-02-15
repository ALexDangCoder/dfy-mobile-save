import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/about_us/ui/about_us.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/create_hard_nft/receive_hard_nft/ui/receive_hard_nft_screen.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/my_account/menu_account/cubit/item_menu_model.dart';
import 'package:Dfy/presentation/my_account/menu_account/cubit/menu_account_cubit.dart';
import 'package:Dfy/presentation/my_account/menu_account/cubit/menu_account_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/presentation/market_place/list_nft/ui/list_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/list_extension.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';
import 'component/Expansion_title_custom.dart';

class MenuAccount extends StatefulWidget {
  const MenuAccount({Key? key}) : super(key: key);

  @override
  _MenuAccountState createState() => _MenuAccountState();
}

class _MenuAccountState extends State<MenuAccount> {
  MenuAccountCubit cubit = MenuAccountCubit();

  @override
  void initState() {
    // TODO: implement initState
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    for (int i = 0; i < listItemMenu.length; i++) {
      openTab.add(false);
    }
    cubit.getLoginState();
    cubit.getWallets();
    super.initState();
  }

  void pushRoute(
      MenuAccountState state, String routeName, BuildContext context) {
    final String walletAddress = PrefsService.getCurrentBEWallet();

    switch (routeName) {
      case 'nft_not_on_market':
        {
          if (state is NoLoginState) {
            showDialog(
              context: context,
              builder: (context) => ConnectWalletDialog(
                navigationTo: ListNft(
                  marketType: MarketType.NOT_ON_MARKET,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
                isRequireLoginEmail: false,
              ),
            ).then((_) => cubit.getLoginState());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListNft(
                  marketType: MarketType.NOT_ON_MARKET,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
              ),
            ).then((_) => cubit.getLoginState());
          }
        }
        break;
      case 'nft_on_sale':
        {
          if (state is NoLoginState) {
            showDialog(
              context: context,
              builder: (context) => ConnectWalletDialog(
                navigationTo: ListNft(
                  marketType: MarketType.SALE,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
                isRequireLoginEmail: false,
              ),
            ).then((_) => cubit.getLoginState());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListNft(
                  marketType: MarketType.SALE,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
              ),
            ).then((_) => cubit.getLoginState());
          }
        }
        break;
      case 'nft_on_auction':
        {
          if (state is NoLoginState) {
            showDialog(
              context: context,
              builder: (context) => ConnectWalletDialog(
                navigationTo: ListNft(
                  marketType: MarketType.AUCTION,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
                isRequireLoginEmail: false,
              ),
            ).then((_) => cubit.getLoginState());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListNft(
                  marketType: MarketType.AUCTION,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
              ),
            ).then((_) => cubit.getLoginState());
          }
        }
        break;
      case 'nft_on_pawn':
        {
          if (state is NoLoginState) {
            showDialog(
              context: context,
              builder: (context) => ConnectWalletDialog(
                navigationTo: ListNft(
                  marketType: MarketType.PAWN,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
                isRequireLoginEmail: false,
              ),
            ).then((_) => cubit.getLoginState());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListNft(
                  marketType: MarketType.PAWN,
                  pageRouter: PageRouter.MY_ACC,
                  walletAddress: walletAddress,
                ),
              ),
            ).then((_) => cubit.getLoginState());
          }
        }
        break;
      case 'about_us':
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutUs(),
            ),
          ).then((_) => cubit.getLoginState());
        }
        break;
      case 'step4' : {
          goTo(
            context,
            const ReceiveHardNFTScreen(),
          );
          break;
      }
      case 'collection_list':
        {
          if(walletAddress.isNotEmpty){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CollectionList(
                  typeScreen: PageRouter.MY_ACC,
                  addressWallet: walletAddress.toLowerCase(),
                ),
              ),
            ).then((_) => cubit.getLoginState());
          }
        }
        break;
      case 'hard_nft_mint':
        {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const EvaluationResult()
          //   ),
          // );//todo
        }
        break;
    }
  }

  final List<ItemMenuModel> listItemMenu = [
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.profile_setting,
      icon: ImageAssets.ic_profile,
      children: [],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.my_nft,
      icon: ImageAssets.ic_nft,
      children: [
        ItemMenuModel.createChild(
          routeName: 'nft_not_on_market',
          title: S.current.not_on_market,
        ),
        ItemMenuModel.createChild(
          routeName: 'nft_on_sale',
          title: S.current.on_sale,
        ),
        ItemMenuModel.createChild(
          routeName: 'nft_on_pawn',
          title: S.current.on_pawn,
        ),
        ItemMenuModel.createChild(
          routeName: 'nft_on_auction',
          title: S.current.on_auction,
        ),
      ],
    ),
    ItemMenuModel.createParent(
      routeName: '',
      title: S.current.hard_nft_management,
      icon: ImageAssets.ic_graph,
      children: [
        ItemMenuModel.createChild(
          routeName: 'about_us',
          title: S.current.hard_nft_list,
        ),
        ItemMenuModel.createChild(
          routeName: 'hard_nft_mint',
          title: S.current.hard_nft_mint_request,
        ),
      ],
    ),
    ItemMenuModel.createParent(
      routeName: 'collection_list',
      title: S.current.my_collection,
      icon: ImageAssets.ic_folder,
      children: [],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.nft_activity,
      icon: ImageAssets.ic_activity,
      children: [],
    ),
    ItemMenuModel.createParent(
      title: S.current.borrower_profile,
      icon: ImageAssets.ic_token_symbol,
      children: [
        ItemMenuModel.createChild(
          routeName: 'step4',
          title: S.current.collateral,
        ),
        ItemMenuModel.createChild(
          routeName: 'about_us',
          title: S.current.contracts,
        ),
      ],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.lender_profile,
      icon: ImageAssets.ic_card,
      children: [],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.setting,
      icon: ImageAssets.ic_setting,
      children: [],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: 'FAQ',
      icon: ImageAssets.ic_faq,
      children: [],
    ),
    ItemMenuModel.createParent(
      routeName: 'about_us',
      title: S.current.about_us,
      icon: ImageAssets.ic_about,
      children: [],
    ),
  ];
  List<bool> openTab = [];

  @override
  void dispose() {
    // TODO: implement dispose
    cubit.dispose();
    super.dispose();
  }

  //todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: listBackgroundColor.first,
      body: StateStreamLayout(
        stream: cubit.stateStream,
        error: AppException('', S.current.something_went_wrong),
        retry: () async {
          await cubit.logout();
        },
        textEmpty: '',
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: listBackgroundColor,
            ),
          ),
          child: Column(
            children: [
              header(),
              Container(
                height: 1,
                color: AppTheme.getInstance().divideColor(),
              ),
              //account detail here
              const SizedBox(height: 0),
              // list item menu
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<MenuAccountCubit, MenuAccountState>(
                          bloc: cubit,
                          builder: (context, state) {
                            if (state is LogonState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StreamBuilder<String?>(
                                    stream: cubit.addressWalletStream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data;
                                      if (data == null) {
                                        return const SizedBox(
                                          height: 0,
                                        );
                                      } else {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            SizedBox(
                                              height: 72,
                                              width: 72,
                                              child: Image.asset(
                                                ImageAssets.ic_profile_circle,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              data.handleString(),
                                              style: textNormalCustom(
                                                AppTheme.getInstance()
                                                    .whiteColor(),
                                                16,
                                                FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  StreamBuilder<String?>(
                                    stream: cubit.emailStream,
                                    builder: (context, snapshot) {
                                      final data = snapshot.data;
                                      if (data == null) {
                                        return const SizedBox(
                                          height: 0,
                                        );
                                      } else {
                                        return Text(
                                          data,
                                          style: textNormalCustom(
                                            AppTheme.getInstance()
                                                .whiteColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox(height: 0);
                            }
                          },
                        ),
                        ...listItemMenu.indexedMap((e, index) {
                          if (e.children.isNotEmpty) {
                            return ExpansionTitleCustom(
                              paddingRightIcon: const EdgeInsets.only(
                                right: 16,
                              ),
                              colorIcon: AppTheme.getInstance().whiteColor(),
                              headerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: openTab[index]
                                    ? colorSkeleton
                                    : Colors.transparent,
                              ),
                              title: [
                                const SizedBox(
                                  height: 60,
                                  width: 18,
                                ),
                                ImageIcon(
                                  AssetImage(e.icon),
                                  size: 28,
                                  color: AppTheme.getInstance().whiteColor(),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  e.title,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteColor(),
                                    20,
                                    FontWeight.w400,
                                  ),
                                )
                              ],
                              expand: openTab[index],
                              onChangeExpand: () {
                                final indexOpen = openTab
                                    .indexWhere((element) => element == true);
                                if (indexOpen >= 0)
                                  openTab[indexOpen] = false;
                                if (indexOpen != index) {
                                  setState(() {
                                    openTab[index] = !openTab[index];
                                  });
                                } else {
                                  setState(() {
                                    openTab[index] = false;
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 3,
                                    height: (e.children.length * 60) - 40,
                                    constraints: const BoxConstraints(
                                      minHeight: 35,
                                    ),
                                    margin: const EdgeInsets.all(21),
                                    color: colorSkeleton,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...e.children.indexedMap(
                                          (element, index) {
                                            final child = element;
                                            return GestureDetector(
                                              onTap: () {
                                                pushRoute(
                                                  cubit.state,
                                                  element.routeName,
                                                  context,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      constraints:const BoxConstraints (
                                                        minHeight: 60
                                                      ),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        color: Colors
                                                            .transparent,
                                                        child: Text(
                                                          child.title,
                                                          style:
                                                              textNormalCustom(
                                                            AppTheme.getInstance()
                                                                .whiteColor()
                                                                .withOpacity(
                                                                  0.8,
                                                                ),
                                                            20,
                                                            FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  for (int i = 0; i < openTab.length; i++) {
                                    setState(() {
                                      openTab[i] = false;
                                    });
                                  }
                                  pushRoute(
                                    cubit.state,
                                    e.routeName,
                                    context,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: openTab[index]
                                        ? colorSkeleton
                                        : Colors.transparent,
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 16,
                                        height: 60,
                                      ),
                                      ImageIcon(
                                        AssetImage(e.icon),
                                        size: 28,
                                        color: AppTheme.getInstance()
                                            .whiteColor(),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        e.title,
                                        style: textNormalCustom(
                                          AppTheme.getInstance().whiteColor(),
                                          20,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }).toList()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Container(
        margin: const EdgeInsets.only(
          right: 20,
          left: 27,
          top: 20,
          bottom: 20,
        ),
        // EdgeInsets.only(left: 0),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  S.current.my_account,
                  style: textNormal(AppTheme.getInstance().textThemeColor(), 20)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 30,
                      width: 30,
                      child: Image.asset(ImageAssets.ic_back),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BlocBuilder<MenuAccountCubit, MenuAccountState>(
                      bloc: cubit,
                      builder: (BuildContext context, state) {
                        if (state is NoLoginState) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                    index: cubit.getIndexLogin(),
                                    isFormConnectWlDialog: true,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                S.current.connect_wallet,
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                style: textNormalCustom(
                                  fillYellowColor,
                                  16,
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              cubit.logout();

                            },
                            child: Image.asset(ImageAssets.ic_logout),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
