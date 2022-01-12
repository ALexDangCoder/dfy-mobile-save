import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/list_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuAccount extends StatefulWidget {
  const MenuAccount({Key? key}) : super(key: key);

  @override
  _MenuAccountState createState() => _MenuAccountState();
}

class _MenuAccountState extends State<MenuAccount> {

  final initData = [
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': []
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': [
        {
          'title': S.current.not_on_market,
        },
        {
          'title': S.current.on_sell,
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
      'children': []
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.my_collection,
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.my_collection,
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': []
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.put_on_sale,
      'children': []
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.my_collection,
    },
    {
      'icon': ImageAssets.ic_profile,
      'title': S.current.my_collection,
    },
  ];

  int tabOpen = -1;

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
            ...initData.indexedMap((e, index) {
                return const  ExpansionTile(
                  title: Text(''),
                  children: [],
                );
            }).toList()
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
