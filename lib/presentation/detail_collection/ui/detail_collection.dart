import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/base_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/filter_activity.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/nft_detail_on_auction.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'widget/body_collection.dart';
import 'widget/filter_nft.dart';

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
    final bool isOwner = true;
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BaseCustomScrollViewDetail(
        isOwner: isOwner,
        initHeight: 190.h,
        title: EXAMPLE_TITLE,
        imageVerified: ImageAssets.ic_dfy,
        imageAvatar: EXAMPLE_IMAGE_URL,
        imageCover: EXAMPLE_IMAGE_URL,
        leading: SizedBox(
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
        actions: [
          Container(
            margin: EdgeInsets.only(
              right: 16.w,
            ),
            child: InkWell(
              onTap: () {
                if (_tabController.index == 0) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => FilterNFT(
                      collectionBloc: detailCollectionBloc,
                      isOwner: isOwner,
                    ),
                  );
                } else {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => FilterActivity(
                      collectionBloc: detailCollectionBloc,
                    ),
                  );
                }
              },
              child: SizedBox(
                height: 32.h,
                width: 32.w,
                child: Image.asset(ImageAssets.img_filter),
              ),
            ),
          ),
        ],
        tabBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: FittedBox(
                child: Text(
                  S.current.nfts,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: FittedBox(
                child: Text(
                  S.current.activity,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
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
        content: [
          BodyDetailCollection(
            detailCollectionBloc: detailCollectionBloc,
            bodyText: 'Euismod amet, sed pulvinar mattis venenatis tristique'
                ' pulvinar aliquam sit. Non orci quis eget cras erat'
                ' elit ornare. Sit pharetra, arcu, sit quis quam'
                ' vulputate. Ornare cursus sed id nibh nisi.'
                ' Vulputate at dictum pharetra tortor aliquet'
                ' ornare nisl nisl.',
            owner: '0xFE5788e2EB714asdfadsff4fd0',
            category: 'adsfasf',
            title: '0xFE5788e2ádfdsafdsfasdfsadsdfEB7144fd0',
            nftStandard: '0xFE5788e2234523453425EB7144fd0',
            contract: '0xFE5788e22345235EB7234532vghvgvghvgvgvh144fd0',
            owners: '234',
            items: '12343',
            volumeTraded: '123324',
            urlTwitter: 'ádf',
            urlTelegram: 'sadf',
            urlInstagram: 'ádf',
            urlFace: 'https://www.facebook.com',
          ),
        ],
        tabBarView: TabBarView(
          controller: _tabController,
          children: [
            NFTSCollection(
              detailCollectionBloc: detailCollectionBloc,
            ),
            TradingHistoryCollection(
              detailCollectionBloc: detailCollectionBloc,
            ),
          ],
        ),
      ),
    );
  }
}
