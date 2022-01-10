import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_detail_eror.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection_state.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/nfts.dart';
import 'package:Dfy/presentation/detail_collection/ui/tab_bar/trading_history.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/base_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/filter_activity.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';
import 'widget/body_collection.dart';
import 'widget/filter_nft.dart';

class DetailCollection extends StatefulWidget {
  const DetailCollection({
    Key? key,
    this.walletAddress,
    required this.collectionAddress,
  }) : super(key: key);
  final String? walletAddress;
  final String collectionAddress;

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
    detailCollectionBloc.getCollection(
      collectionAddress: '0x9371f7d8710bf370136b1eba91be1dc98e90a45c',
    ); //todo collection address

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isOwner = false;
    if (detailCollectionBloc.arg.owner == widget.walletAddress) {
      isOwner = true;
    } else {
      isOwner = false;
    }

    return BlocBuilder<DetailCollectionBloc, CollectionDetailState>(
      bloc: detailCollectionBloc,
      builder: (context, state) {
        if (state is LoadingData) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                  ),
                  height: 764.h,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        color: AppTheme.getInstance().selectDialogColor(),
                        height: 145.h,
                      ),
                      Positioned(
                        top: 111.h,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.getInstance().bgBtsColor(),
                              width: 6.w,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getInstance().selectDialogColor(),
                              shape: BoxShape.circle,
                            ),
                            height: 68.h,
                            width: 68.h,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200.h,
                        left: 16.w,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.getInstance().bgBtsColor(),
                              width: 6.w,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.h),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getInstance().selectDialogColor(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.h),
                              ),
                            ),
                            height: 25.h,
                            width: 155.h,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 240.h,
                        left: 16.w,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.getInstance().bgBtsColor(),
                              width: 6.w,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.h),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance()
                                      .selectDialogColor(),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.h),
                                  ),
                                ),
                                height: 16.h,
                                width: 300.w,
                              ),
                              spaceH10,
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.getInstance()
                                      .selectDialogColor(),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.h),
                                  ),
                                ),
                                height: 16.h,
                                width: 300.w,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          );
        } else if (state is LoadingDataFail) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                height: 764.h,
                child: CollectionDetailError(
                  collectionAddress: widget.collectionAddress,
                  cubit: detailCollectionBloc,
                ),
              ),
            ),
          );
        } else if (state is LoadingDataSuccess) {
          final list = detailCollectionBloc.arg;
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
              title: list.name ?? '',
              imageVerified: ImageAssets.ic_dfy,
              imageAvatar: ApiConstants.BASE_URL_IMAGE + (list.avatarCid ?? ''),
              imageCover: ApiConstants.BASE_URL_IMAGE + (list.coverCid ?? ''),
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
                  bodyText: (list.description ?? '').parseHtml(),
                  owner: list.owner ?? '',
                  category: list.categoryType ?? '',
                  title: list.name ?? '',
                  nftStandard: detailCollectionBloc
                      .funGetTypeNFT(list.collectionType ?? 0),
                  contract: list.collectionAddress ?? '',
                  owners: '${list.nftOwnerCount ?? 0}',
                  items: '${list.totalNft ?? 0}',
                  volumeTraded: '${list.totalVolumeTraded ?? 0}',
                  urlTwitter: detailCollectionBloc.linkUrlTwitter,
                  urlTelegram: detailCollectionBloc.linkUrlTelegram,
                  urlInstagram: detailCollectionBloc.linkUrlInstagram,
                  urlFace: detailCollectionBloc.linkUrlFacebook,
                ),
              ],
              tabBarView: TabBarView(
                controller: _tabController,
                children: [
                  NFTSCollection(
                    detailCollectionBloc: detailCollectionBloc,
                  ),
                  ActivityCollection(
                    detailCollectionBloc: detailCollectionBloc,
                    addressWallet: widget.walletAddress ?? '',
                  ),
                ],
              ),
            ),
          );
        } else {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 150.h),
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(
                      ImageAssets.img_search_empty,
                    ),
                    height: 120.h,
                    width: 120.w,
                  ),
                  SizedBox(
                    height: 17.7.h,
                  ),
                  Text(
                    S.current.no_result_found,
                    style: textNormal(
                      Colors.white54,
                      20.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
