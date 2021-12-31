import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/filter_activity.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      floatingActionButton: false
          ? GestureDetector(
              onTap: () {
                print('hello');
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:
                          AppTheme.getInstance().fillColor().withOpacity(0.3),
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: const Offset(0, 10), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  ImageAssets.img_float_btn,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : SizedBox.shrink(),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 764.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
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
                              print(_tabController.index);
                              if (_tabController.index == 0) {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => FilterNFT(
                                    collectionBloc: detailCollectionBloc,
                                    isOwner: false,
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
                    ),
                    Expanded(
                      child: BaseCollection(
                        filterFunc: () {
                          // showModalBottomSheet(
                          //   backgroundColor: Colors.transparent,
                          //   context: context,
                          //   builder: (context) => FilterNFT(
                          //     collectionBloc: detailCollectionBloc,
                          //     isOwner: false,
                          //   ),
                          // );
                        },
                        tabBar: TabBar(
                          controller: _tabController,
                          //  isScrollable: true,
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
                        body: TabBarView(
                          controller: _tabController,
                          children: [
                            NFTSCollection(
                              detailCollectionBloc: detailCollectionBloc,
                            ),
                            const TradingHistoryCollection(),
                          ],
                        ),
                        child: BodyDetailCollection(
                          detailCollectionBloc: detailCollectionBloc,
                          bodyText:
                              'Euismod amet, sed pulvinar mattis venenatis tristique'
                              ' pulvinar aliquam sit. Non orci quis eget cras erat'
                              ' elit ornare. Sit pharetra, arcu, sit quis quam'
                              ' vulputate. Ornare cursus sed id nibh nisi.'
                              ' Vulputate at dictum pharetra tortor aliquet'
                              ' ornare nisl nisl.',
                          owner: '0xFE5788e2EB714asdfadsff4fd0',
                          category: 'adsfasf',
                          title: '0xFE5788e2ádfdsafdsfasdfsadsdfEB7144fd0',
                          nftStandard: '0xFE5788e2234523453425EB7144fd0',
                          contract:
                              '0xFE5788e22345235EB7234532vghvgvghvgvgvh144fd0',
                          owners: '234',
                          items: '12343',
                          volumeTraded: '123324',
                          urlTwitter: 'ádf',
                          urlTelegram: 'sadf',
                          urlInstagram: 'ádf',
                          urlFace: 'https://www.facebook.com',
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 105.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 80.w,
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
                          height: 74.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: 'https://tse1.mm.bing.net/th?id=OIP.'
                                'OfaVuv27apRglGh0_CL9TQHaEK&pid=Api&P=0&w=340&h=192',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: true
                            ? const SizedBox.shrink()
                            : Image.asset(ImageAssets.ic_dfy),
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
}
