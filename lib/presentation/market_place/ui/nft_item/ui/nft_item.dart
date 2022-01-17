import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/bloc/nft_item_cubit.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class NFTItemWidget extends StatefulWidget {
  const NFTItemWidget({
    Key? key,
    required this.nftMarket,
  }) : super(key: key);

  final NftMarket nftMarket;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItemWidget> {
  final formatValue = NumberFormat('###,###,###.###', 'en_US');
  late VideoPlayerController? _controller;
  late CountdownTimerController countdownController;
  late CountdownTimerController coutdownStartTime;
  DateTime? startTimeAuction;
  DateTime? endTimeAuction;
  late NftItemCubit cubitNft;
  late Timer timer;
  bool isShowStartTimeFtText = false;
  late int timeStartStamp;
  String textShowStartFtTime = '';

  @override
  void initState() {
    super.initState();
    if (widget.nftMarket.typeImage == TypeImage.VIDEO) {
      _controller = VideoPlayerController.network(widget.nftMarket.image ?? '');
      _controller!.addListener(() {
        setState(() {});
      });
      _controller!.setLooping(true);
      _controller!.initialize().then((_) => setState(() {}));
    }
    cubitNft = NftItemCubit();
    if (widget.nftMarket.marketType == MarketType.AUCTION) {
      startTimeAuction = cubitNft.parseTimeServerToDateTime(
        // value: widget.nftMarket.startTime ?? 0,
        // value: 1642637464000,
        value: 1642471860000,
      );
      endTimeAuction = cubitNft.parseTimeServerToDateTime(
        // value: (widget.nftMarket.endTime == 0) ? 0 : 0,
        // value: 1642637464000,
        value: 1642558260000,
      );
      //todo đang hardcode startTime
      // timeStartStamp = 1642637464000;
      countdownController = CountdownTimerController(
        endTime: endTimeAuction!.millisecondsSinceEpoch,
      );

      coutdownStartTime = CountdownTimerController(
        endTime: startTimeAuction!.millisecondsSinceEpoch,
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
    if (widget.nftMarket.typeImage == TypeImage.VIDEO) {
      _controller!.dispose();
    }
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.nftMarket.typeImage == TypeImage.VIDEO) {
          _controller!.pause();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NFTDetailScreen(
                  key: nftKey,
                  typeMarket: widget.nftMarket.marketType ?? MarketType.SALE,
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
                      if (widget.nftMarket.typeImage == TypeImage.VIDEO) {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      } else {
                        Navigator.push(
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
                      }
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
                                ? CachedNetworkImage(
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            AppTheme.getInstance().bgBtsColor(),
                                      ),
                                    ),
                                    imageUrl: widget.nftMarket.image ?? '',
                                    fit: BoxFit.cover,
                                  )
                                : VideoPlayer(_controller!),
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
                                  child: CachedNetworkImage(
                                    imageUrl: widget.nftMarket.urlToken ?? '',
                                  ),
                                )
                              else
                                const Image(
                                  image: AssetImage(ImageAssets.symbol),
                                ),
                              SizedBox(
                                width: 4.18.h,
                              ),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  formatValue.format(widget.nftMarket.price),
                                  style: textNormalCustom(
                                    Colors.yellow,
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
                          '${widget.nftMarket.numberOfCopies} '
                          '${S.current.of_all} '
                          '${widget.nftMarket.totalCopies}',
                          style: textNormalCustom(
                            Colors.white,
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
    if (type == MarketType.AUCTION) {
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
                color: Colors.white,
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
            _controller!.value.isPlaying
                ? Icons.pause_circle_outline_sharp
                : Icons.play_circle_outline_sharp,
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
          'Pawn',
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
        return Container();
    }
  }
}
