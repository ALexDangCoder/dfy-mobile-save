import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'body_collection.dart';
import 'filter_nft.dart';

class DetailCollection extends StatefulWidget {
  const DetailCollection({Key? key}) : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollection>
    with TickerProviderStateMixin {
  late final DetailCollectionBloc detailCollectionBloc;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    detailCollectionBloc = DetailCollectionBloc();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: BaseCollection(
            filterFunc: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => FilterNFT(
                  collectionBloc: detailCollectionBloc,
                ),
              );
            },
            tabBar: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    '         ${S.current.nfts}        ',
                    style: textNormalCustom(
                      null,
                      14.sp,
                      FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.trading_history,
                    style: textNormalCustom(
                      null,
                      14.sp,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
              labelColor: AppTheme.getInstance().whiteColor(),
              unselectedLabelColor: AppTheme.getInstance().whiteColor(),
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
            body: TabBarView(
              controller: _tabController,
              children: [
                NftsCollection(
                  detailCollectionBloc: detailCollectionBloc,
                ),
                const TradingHistoryCollection(),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: 375.w,
                      height: 145.h,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl: 'https://tse1.mm.bing.net/th?id=OIP.'
                          'OfaVuv27apRglGh0_CL9TQHaEK&pid=Api&P=0&w=340&h=192',
                    ),
                    BodyDetailCollection(
                      detailCollectionBloc: detailCollectionBloc,
                      bodyText:
                          'Euismod amet, sed pulvinar mattis venenatis tristique'
                          ' pulvinar aliquam sit. Non orci quis eget cras erat'
                          ' elit ornare. Sit pharetra, arcu, sit quis quam'
                          ' vulputate. Ornare cursus sed id nibh nisi.'
                          ' Vulputate at dictum pharetra tortor aliquet'
                          ' ornare nisl nisl.',
                      owner: '0xFE5788e2...EB7144fd0',
                      category: '0xFE5788e2...EB7144fd0',
                      title: '0xFE5788e2...EB7144fd0',
                      nftStandard: '0xFE5788e2...EB7144fd0',
                      contract: '0xFE5788e2...EB7144fd0',
                    ),
                  ],
                ),
                Positioned(
                  top: 105.h,
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.getInstance().bgBtsColor(),
                        width: 6.w,
                      ),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: 74.w,
                      height: 74.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://tse1.mm.bing.net/th?id=OIP.'
                            'OfaVuv27apRglGh0_CL9TQHaEK&pid=Api&P=0&w=340&h=192',
                        fit: BoxFit.cover,
                        // placeholder: (context, url) => Center(
                        //   child: CircularProgressIndicator(
                        //     color: AppTheme.getInstance().whiteColor(),
                        //   ),
                        // ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  left: 16.h,
                  child: SizedBox(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 32.h,
                        width: 32.w,
                        child: Image.asset(ImageAssets.img_back),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  right: 16.h,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => FilterNFT(
                          collectionBloc: detailCollectionBloc,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 32.h,
                      width: 32.w,
                      child: Image.asset(ImageAssets.img_filter),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
