import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/menu_account/cubit/menu_account_cubit.dart';
import 'package:Dfy/presentation/put_on_market/ui/put_on_market_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/list_extension.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/Expansion_title_custom.dart';

class MenuAccount extends StatefulWidget {
  const MenuAccount({Key? key}) : super(key: key);

  @override
  _MenuAccountState createState() => _MenuAccountState();
}

class _MenuAccountState extends State<MenuAccount> {
  MenuAccountCubit cubit = MenuAccountCubit();

  int currentTab = -1;
  int selectedTab = -1;


  @override
  void initState() {
    // TODO: implement initState
    for (int i=0 ; i< initData.length; i++ ){
      openTab.add(false);
    }
    super.initState();
  }

  void pushRoute(String routeName, BuildContext context) {
    switch (routeName) {
      case 'put_on_market':
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PutOnMarket(),
            ),
          );
          break;
        }
    }
  }

  final initData = [
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': [
        {
          'title': S.current.not_on_market,
        },
        {
          'title': S.current.on_sale,
        },
        {
          'title': S.current.on_pawn,
        },
        {
          'title': S.current.on_auction,
        },
      ],
      'routeName': 'put_on_market'
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': [
        {
          'title': S.current.not_on_market,
        },
        {
          'title': S.current.on_sale,
        },
        {
          'title': S.current.on_pawn,
        },
        {
          'title': S.current.on_auction,
        },
      ]
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
    },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.my_collection,
    // },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.my_collection,
    // },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.put_on_sale,
    //   'children': [
    //     {
    //       'title': S.current.not_on_market,
    //     },
    //     {
    //       'title': S.current.on_sale,
    //     },
    //     {
    //       'title': S.current.on_pawn,
    //     },
    //     {
    //       'title': S.current.on_auction,
    //     },
    //   ]
    // },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.put_on_sale,
    //   'children': []
    // },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.my_collection,
    // },
    // {
    //   'icon': ImageAssets.ic_profile,
    //   'title': S.current.my_collection,
    // },
  ];
  List<bool> openTab = [];



  //todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Divider(
              thickness: 1,
              color: AppTheme.getInstance().divideColor(),
            ),
            //account detail here
            const SizedBox(height: 0),
            // list item menu
            Expanded(
              child: Column(
                children: [
                  ...initData.indexedMap((e, index) {
                    if (e.arrayValueOrEmpty('children').isNotEmpty) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     final indexOpen = openTab
                          //           .indexWhere((element) => element == true);
                          //       if (indexOpen >=0)openTab[indexOpen] = false;
                          //       setState(() {
                          //         openTab[index] = !openTab[index];
                          //       });
                          //   },
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(10),
                          //     child: Row(
                          //       children: [
                          //         ImageIcon(
                          //           AssetImage(e.stringValueOrEmpty('icon')),
                          //           size: 28,
                          //           color: AppTheme.getInstance().whiteColor(),
                          //         ),
                          //         Text(
                          //           e.stringValueOrEmpty('title'),
                          //           style: textNormalCustom(
                          //             AppTheme.getInstance().whiteColor(),
                          //             20,
                          //             FontWeight.w400,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          ExpansionTitleCustom(
                            title: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Row(
                                children: [
                                  ImageIcon(
                                    AssetImage(e.stringValueOrEmpty('icon')),
                                    size: 28,
                                    color: AppTheme.getInstance().whiteColor(),
                                  ),
                                  Text(
                                    e.stringValueOrEmpty('title'),
                                    style: textNormalCustom(
                                      AppTheme.getInstance().whiteColor(),
                                      20,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            expand: openTab[index],
                            onChangeExpand: (){
                              final indexOpen = openTab
                                  .indexWhere((element) => element == true);
                              if (indexOpen >=0)openTab[indexOpen] = false;
                              if (indexOpen != index ) {
                                setState(() {
                                openTab[index] = !openTab[index];
                              });
                              } else {
                                setState(() {
                                  openTab[index] = false;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                ...e.arrayValueOrEmpty('children').indexedMap(
                                  (element, index) {
                                    final child =
                                        element as Map<String, dynamic>;
                                    return Row(
                                      children: [
                                        Text(child.stringValueOrEmpty('title'))
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            for (int i=0; i<openTab.length; i++){
                              setState(() {
                                openTab[i] = false;
                              });
                            }
                            pushRoute(
                                e.stringValueOrEmpty('routeName'), context);
                          },
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage(e.stringValueOrEmpty('icon')),
                                size: 28,
                                color: AppTheme.getInstance().whiteColor(),
                              ),
                              Text(
                                e.stringValueOrEmpty('title'),
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteColor(),
                                  20,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }).toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container header() {
    return Container(
      width: 343,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(width: 26.w,),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),

          Text(
            S.current.put_on_market,
            style: textNormal(AppTheme.getInstance().textThemeColor(), 20)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_close),
          ),
        ],
      ),
    );
  }
}
