import 'dart:async';
import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/bloc/nft_item_cubit.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NFTItemWidget extends StatefulWidget {
  const NFTItemWidget({
    Key? key,
    required this.nftMarket,
    this.pageRouter,
    this.isChoosing = false,
    this.callBack,
  }) : super(key: key);

  final NftMarket nftMarket;
  final PageRouter? pageRouter;
  final bool? isChoosing;
  final Function()? callBack;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItemWidget> {
  final formatValue = NumberFormat('###,###,###.###', 'en_US');
  late CountdownTimerController countdownController;
  late CountdownTimerController coutdownStartTime;
  DateTime? startTimeAuction;
  DateTime? endTimeAuction;
  late NftItemCubit cubitNft;
  Timer? timer;
  bool isShowStartTimeFtText = false;
  late int timeStartStamp;
  String textShowStartFtTime = '';

  @override
  void initState() {
    super.initState();
    cubitNft = NftItemCubit();
    if (widget.nftMarket.marketType == MarketType.AUCTION &&
        widget.pageRouter != PageRouter.MY_ACC) {
      startTimeAuction = cubitNft.parseTimeServerToDateTime(
        value: widget.nftMarket.startTime ?? 0,
      );
      endTimeAuction = cubitNft.parseTimeServerToDateTime(
        value: widget.nftMarket.endTime ?? 0,
      );
      countdownController = CountdownTimerController(
        endTime: endTimeAuction?.millisecondsSinceEpoch ?? 0,
      );

      coutdownStartTime = CountdownTimerController(
        endTime: startTimeAuction?.millisecondsSinceEpoch ?? 0,
      );

      ///set time show text start in when auction not start yet
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        isShowStartTimeFtText = !isShowStartTimeFtText;
        cubitNft.isNotStartYet(startTime: startTimeAuction!);
        setState(() {});
      });
    } else {
      //todo when not auction
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nftMarket.marketType == MarketType.AUCTION &&
        widget.pageRouter != PageRouter.MY_ACC) {
      startTimeAuction = cubitNft.parseTimeServerToDateTime(
        value: widget.nftMarket.startTime ?? 0,
      );
      endTimeAuction = cubitNft.parseTimeServerToDateTime(
        value: widget.nftMarket.endTime ?? 0,
      );
      countdownController = CountdownTimerController(
        endTime: endTimeAuction?.millisecondsSinceEpoch ?? 0,
      );

      coutdownStartTime = CountdownTimerController(
        endTime: startTimeAuction?.millisecondsSinceEpoch ?? 0,
      );
    }
    return GestureDetector(
      onTap: () {
        (widget.isChoosing ?? false)
            ? Navigator.pop(
                context,
                widget.nftMarket,
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NFTDetailScreen(
                    key: nftKey,
                    typeMarket: widget.nftMarket.marketType ?? MarketType.SALE,
                    marketId: widget.nftMarket.marketId,
                    typeNft: widget.nftMarket.typeNFT,
                    nftId: widget.nftMarket.nftId,
                    pawnId: widget.nftMarket.pawnId,
                    collectionAddress: widget.nftMarket.collectionAddress,
                    nftTokenId: widget.nftMarket.nftTokenId,
                    pageRouter: widget.pageRouter,
                  ),
                  settings: const RouteSettings(
                    name: AppRouter.nft_detail,
                  ),
                ),
              );
      },
      child: Stack(
        children: [
          Container(
            height: 231.h,
            width: 156.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppTheme.getInstance().selectDialogColor(),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                top: 8.h,
                right: 8.w,
                bottom: 8.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      (widget.isChoosing ?? false)
                          ? widget.callBack
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NFTDetailScreen(
                                  typeMarket: widget.nftMarket.marketType ??
                                      MarketType.SALE,
                                  marketId: widget.nftMarket.marketId,
                                  typeNft: widget.nftMarket.typeNFT,
                                  nftId: widget.nftMarket.nftId,
                                  pawnId: widget.nftMarket.pawnId,
                                ),
                              ),
                            );
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 129.h,
                          width: 140.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: (widget.nftMarket.typeImage !=
                                    TypeImage.VIDEO)
                                ? FadeInImage.assetNetwork(
                                    placeholder: ImageAssets.image_loading,
                                    image: widget.nftMarket.image ?? '',
                                    imageCacheHeight: 200,
                                    imageErrorBuilder: (context, url, error) {
                                      return Center(
                                        child: Text(
                                          S.current.unload_image,
                                          style: textNormalCustom(
                                            Colors.white,
                                            14,
                                            FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                    placeholderCacheHeight: 50,
                                    fit: BoxFit.cover,
                                  )
                                : FadeInImage.assetNetwork(
                                    placeholder: ImageAssets.image_loading,
                                    image: widget.nftMarket.cover ?? '',
                                    imageCacheHeight: 200,
                                    imageErrorBuilder: (context, url, error) {
                                      return Center(
                                        child: Text(
                                          S.current.unload_image,
                                          style: textNormalCustom(
                                            Colors.white,
                                            14,
                                            FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                    placeholderCacheHeight: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        playVideo(widget.nftMarket.typeImage),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: 16.h,
                    child: Text(
                      widget.nftMarket.name ?? '',
                      style: textNormalCustom(
                        null,
                        13,
                        FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  propertyNFT(widget.nftMarket.marketType),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 16.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 16.h,
                          child: Row(
                            children: [
                              if (widget.nftMarket.urlToken?.isNotEmpty ??
                                  false)
                                ClipRRect(
                                  child: widget.nftMarket.marketType ==
                                          MarketType.NOT_ON_MARKET
                                      ? null
                                      : Image.network(
                                          widget.nftMarket.urlToken ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                )
                              else
                                widget.nftMarket.marketType ==
                                        MarketType.NOT_ON_MARKET
                                    ? const SizedBox.shrink()
                                    : const Image(
                                        image: AssetImage(ImageAssets.symbol),
                                      ),
                              SizedBox(
                                width: 4.18.h,
                              ),
                              SizedBox(
                                width: 70.w,
                                child: widget.nftMarket.marketType ==
                                        MarketType.NOT_ON_MARKET
                                    ? null
                                    : Text(
                                        formatValue
                                            .format(widget.nftMarket.price),
                                        style: textNormalCustom(
                                          AppTheme.getInstance().yellowColor(),
                                          13,
                                          FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${widget.nftMarket.numberOfCopies ?? 0} '
                          '${S.current.of_all} '
                          '${widget.nftMarket.totalCopies ?? 0}',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            13,
                            FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          hardNft(widget.nftMarket.typeNFT),
          timeCountdown(widget.nftMarket.marketType),
        ],
      ),
    );
  }

  Widget hardNft(TypeNFT? type) {
    if (type == TypeNFT.HARD_NFT) {
      return Padding(
        padding: EdgeInsets.only(left: 117.w),
        child: const Image(
          image: AssetImage(ImageAssets.img_hard_nft),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget timeCountdown(MarketType? type) {
    if (type == MarketType.AUCTION && widget.pageRouter != PageRouter.MY_ACC) {
      return Padding(
        padding: EdgeInsets.only(top: 119.h, left: 26.5.w),
        child: Container(
          width: 107.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFCD28).withOpacity(0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(12.5.r),
            ),
            border: Border.all(
              color: const Color(0xFFFF9E12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                const AssetImage(
                  ImageAssets.ic_clock2,
                ),
                color: AppTheme.getInstance().whiteColor(),
                size: 13.sp,
              ),
              SizedBox(
                width: 5.w,
              ),
              if (cubitNft.isNotStartYet(startTime: startTimeAuction!)) ...[
                CountdownTimer(
                  controller: coutdownStartTime,
                  widgetBuilder: (_, CurrentRemainingTime? time) {
                    if (time == null) {
                      return Text(
                        '00:00:00:00',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          13,
                          FontWeight.w600,
                        ),
                      );
                    }
                    return isShowStartTimeFtText
                        ? Text(
                            S.current.start_in,
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              13,
                              FontWeight.w600,
                            ),
                          )
                        : Text(
                            '${time.days ?? 0}:${time.hours ?? 0}:${time.min ?? 0}:${time.sec ?? 0}',
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              13,
                              FontWeight.w600,
                            ),
                          );
                  },
                )
              ] else ...[
                if (cubitNft.isOutOfTimeAuction(endTime: endTimeAuction!))
                  CountdownTimer(
                    controller: countdownController,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Text(
                          '00:00:00:00',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            13,
                            FontWeight.w600,
                          ),
                        );
                      }
                      return Text(
                        '${time.days ?? 0}:${time.hours ?? 0}:${time.min ?? 0}:${time.sec}',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          13,
                          FontWeight.w600,
                        ),
                      );
                    },
                  )
                else
                  Text(
                    '00:00:00:00',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      13,
                      FontWeight.w600,
                    ),
                  )
              ]
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget textStartForAuction(String text) {
    return Text(
      text,
      style: textNormalCustom(
        AppTheme.getInstance().whiteColor(),
        13,
        FontWeight.w600,
      ),
    );
  }

  Widget playVideo(TypeImage? type) {
    if (type == TypeImage.VIDEO) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(
            top: 90.h,
            right: 6.w,
          ),
          child: Icon(
            Icons.play_circle_outline_sharp,
            size: 24.sp,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget propertyNFT(MarketType? type) {
    switch (type) {
      case MarketType.PAWN:
        return Text(
          'Requesting loan',
          style: textNormalCustom(
            AppTheme.getInstance().blueColor(),
            13,
            FontWeight.w600,
          ),
        );
      case MarketType.AUCTION:
        return Text(
          'Auction',
          style: textNormalCustom(
            AppTheme.getInstance().failTransactionColors(),
            13,
            FontWeight.w600,
          ),
        );
      case MarketType.SALE:
        return Text(
          'Sale',
          style: textNormalCustom(
            AppTheme.getInstance().successTransactionColors(),
            13,
            FontWeight.w600,
          ),
        );
      default:
        return Text(
          'Not on market',
          style: textNormalCustom(
            AppTheme.getInstance().successTransactionColors(),
            13,
            FontWeight.w600,
          ),
        );
    }
  }
}
