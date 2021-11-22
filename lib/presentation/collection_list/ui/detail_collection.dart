import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/nav.dart';
import 'package:Dfy/presentation/collection_list/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/collection_list/ui/tab_bar/trading_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

import 'header.dart';

class DetailCollection extends StatefulWidget {
  const DetailCollection({Key? key}) : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollection> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 48.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 764.h,
                    width: 375.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().borderItemColor(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.h),
                        topRight: Radius.circular(30.h),
                      ),
                    ),
                    child: Column(
                      children: [

                        const HeaderCollection(
                          owner: '0xFE5788e2...EB7144fd0',
                          category: 'Art',
                          title: 'Artwork collection',
                          urlBackground: 'assets/images/Boahancock.jpg',
                          urlAvatar: 'assets/images/Boahancock.jpg',
                          bodyText:
                              'Euismod amet, sed pulvinar mattis venenatis tristique pulvinar aliquam sit. Non orci quis eget cras erat elit ornare. Sit pharetra, arcu, sit quis quam vulputate. Ornare cursus sed id nibh nisi. Vulputate at dictum pharetra tortor aliquet ornare nisl nisl.',
                          contract: '0xFE5788e2...EB7144fd0',
                          nftStandard: 'ERC - 1155',
                        ),
                        const NavCollection(
                          items: '1025',
                          owners: '326',
                          volumeTraded: '\$1,396,175',
                        ),
                        line,
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                spaceH12,
                                Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      color: backgroundBottomSheetColor,
                                    ),
                                    height: 35.h,
                                    width: 253.w,
                                    child: TabBar(
                                      tabs: [
                                        Tab(
                                          text: S.current.nfts,
                                        ),
                                        Tab(
                                          text: S.current.trading_history,
                                        ),
                                      ],
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.white,
                                      indicator: RectangularIndicator(
                                        bottomLeftRadius: 10,
                                        bottomRightRadius: 10,
                                        topLeftRadius: 10,
                                        topRightRadius: 10,
                                        color: formColor,
                                        horizontalPadding: 3,
                                        verticalPadding: 3,
                                      ),
                                    ),
                                  ),
                                ),
                                spaceH12,
                                line,
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      NftsCollection(),
                                      TradingHistoryCollection(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
