import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/filter_nft.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

import 'body_collection.dart';

class HeaderCollection extends StatefulWidget {
  final DetailCollectionBloc collectionBloc;
  final String urlBackground;
  final String urlAvatar;
  final DetailCollectionBloc detailCollectionBloc;
  final String owner;
  final String contract;
  final String nftStandard;
  final String category;
  final String title;
  final String bodyText;

  const HeaderCollection({
    Key? key,
    required this.urlBackground,
    required this.urlAvatar,
    required this.collectionBloc,
    required this.detailCollectionBloc,
    required this.owner,
    required this.contract,
    required this.nftStandard,
    required this.category,
    required this.title,
    required this.bodyText,
  }) : super(key: key);

  @override
  _HeaderCollectionState createState() => _HeaderCollectionState();
}

class _HeaderCollectionState extends State<HeaderCollection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              width: 375.w,
              height: 145.h,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppTheme.getInstance().whiteColor(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: widget.urlBackground,
            ),
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (_, index) {
                  return [
                    SliverToBoxAdapter(
                      child: BodyDetailCollection(
                        detailCollectionBloc: widget.detailCollectionBloc,
                        bodyText: widget.bodyText,
                        owner: widget.owner,
                        category: widget.category,
                        title: widget.title,
                        nftStandard: widget.nftStandard,
                        contract: widget.contract,
                      ),
                    )
                  ];
                },
                body: DefaultTabController(
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
                              detailCollectionBloc: widget.detailCollectionBloc,
                            ),
                            const TradingHistoryCollection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
                color: AppTheme.getInstance().borderItemColor(),
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
                imageUrl: widget.urlAvatar,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  collectionBloc: widget.collectionBloc,
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
    );
  }
}
