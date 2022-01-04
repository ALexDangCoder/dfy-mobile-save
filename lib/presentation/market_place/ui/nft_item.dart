import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  late VideoPlayerController _controller;

  @override
  void initState() {
    if (widget.nftMarket.typeImage == TypeImage.VIDEO) {
      _controller = VideoPlayerController.network(widget.nftMarket.image);
      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(true);
      _controller.initialize().then((_) => setState(() {}));
      _controller.play();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
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
                    Stack(
                      children: [
                        Container(
                          height: 129.h,
                          width: 140.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: (widget.nftMarket.typeImage !=
                                TypeImage.VIDEO) ? CachedNetworkImage(
                              placeholder: (context, url) =>
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.getInstance()
                                          .bgBtsColor(),
                                    ),
                                  ),
                              imageUrl: widget.nftMarket.image,
                              fit: BoxFit.cover,
                            ):VideoPlayer(_controller),
                          ),
                        ),
                        playVideo(widget.nftMarket.typeImage),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 16.h,
                      child: Text(
                        widget.nftMarket.name,
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
                                const Image(
                                  image: AssetImage('assets/images/symbol.png'),
                                ),
                                SizedBox(
                                  width: 4.18.h,
                                ),
                                Text(
                                  formatValue.format(widget.nftMarket.price),
                                  style: textNormalCustom(
                                    Colors.yellow,
                                    13,
                                    FontWeight.w600,
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
      ],
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
        padding: EdgeInsets.only(top: 119.h, left: 35.5.w),
        child: Container(
          width: 85.w,
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
            children: [
              SizedBox(
                width: 7.w,
              ),
              ImageIcon(
                const AssetImage(
                  ImageAssets.ic_clock2,
                ),
                color: Colors.white,
                size: 13.sp,
              ),
              SizedBox(
                width: 7.w,
              ),
              Text(
                '15:02:02',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  13,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget playVideo(TypeImage? type) {
    if (type == TypeImage.VIDEO) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 49.h,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 24.sp,
              color: Colors.white,
            ),
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
