import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/nav.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
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
  late final DetailCollectionBloc detailCollectionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailCollectionBloc = DetailCollectionBloc();
  }

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
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        HeaderCollection(
                          owner: '0xFE5788e2...EB7144fd0',
                          category: 'Art',
                          title: 'Artwork collection',
                          urlBackground: 'assets/images/Boahancock.jpg',
                          urlAvatar: 'assets/images/Boahancock.jpg',
                          bodyText:
                              'Euismod amet, sed pulvinar mattis venenatis tristique pulvinar aliquam sit. Non orci quis eget cras erat elit ornare. Sit pharetra, arcu, sit quis quam vulputate. Ornare cursus sed id nibh nisi. Vulputate at dictum pharetra tortor aliquet ornare nisl nisl.',
                          contract: '0xFE5788e2...EB7144fd0',
                          nftStandard: 'ERC - 1155',
                          collectionBloc: detailCollectionBloc,
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.r),
                                      ),
                                      color: backgroundBottomSheetColor,
                                    ),
                                    height: 35.h,
                                    width: 253.w,
                                    child: TabBar(
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            S.current.nfts,
                                            style: textNormalCustom(
                                                null, 14.sp, FontWeight.bold),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            S.current.trading_history,
                                            style: textNormalCustom(
                                                null, 14.sp, FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                      labelColor:
                                          AppTheme.getInstance().whiteColor(),
                                      unselectedLabelColor:
                                          AppTheme.getInstance().whiteColor(),
                                      indicator: RectangularIndicator(
                                        bottomLeftRadius: 10.r,
                                        bottomRightRadius: 10.r,
                                        topLeftRadius: 10.r,
                                        topRightRadius: 10.r,
                                        color: formColor,
                                        horizontalPadding: 3.w,
                                        verticalPadding: 3.h,
                                      ),
                                    ),
                                  ),
                                ),
                                spaceH12,
                                line,
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      NftsCollection(
                                        detailCollectionBloc:
                                            detailCollectionBloc,
                                      ),
                                      const TradingHistoryCollection(),
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
