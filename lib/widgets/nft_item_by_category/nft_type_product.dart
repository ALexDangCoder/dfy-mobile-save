import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum NFT_CATEGORY {
  SALE,
  PAWN,
  AUCTION,
}
enum NFT_IS_HARD {
  HARD_NFT,
  NON_HARD_NFT,
}
enum NFT_IS_VID_OR_IMG {
  VIDEO_NFT,
  IMG_NFT,
}

class NftProduct extends StatefulWidget {
  const NftProduct({
    required this.nftName,
    required this.price,
    required this.nftCategory,
    required this.nftIsHard,
    required this.nftIsVidOrImg,
    Key? key,
  }) : super(key: key);
  final String nftName;
  final double price;
  final NFT_CATEGORY nftCategory;
  final NFT_IS_HARD nftIsHard;
  final NFT_IS_VID_OR_IMG nftIsVidOrImg;

  @override
  _NftProductState createState() => _NftProductState();
}

class _NftProductState extends State<NftProduct> {
  final formatValue = NumberFormat('###,###,###.###', 'en_US');

  // formatValue.format(DOUBLE), // HOW TO USE IT
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 231.h,
          width: 156.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppTheme.getInstance().selectDialogColor(),
          ),
          padding: EdgeInsets.only(
            top: 8.h,
            bottom: 16.h,
            left: 8.w,
            right: 8.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  //this container is IMAGE NFT
                  imgNFT(),
                  isHaveButtonPlayVideo(widget.nftIsVidOrImg),
                ],
              ),
              spaceH6,
              Text(
                widget.nftName,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  13.sp,
                  FontWeight.w600,
                ),
              ),
              spaceH2,
              txtTypeNft(nftCategory: widget.nftCategory),
              spaceH16,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/symbol.png'),
                        ),
                        SizedBox(
                          width: 4.18.h,
                        ),
                        Text(
                          formatValue.format(widget.price),
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '1 of 1',
                      style: TextStyle(
                        color: AppTheme.getInstance().failTransactionColors(),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //widget below will not appear if is not hard nft
        isHardNft(widget.nftIsHard),
        //widget below will not appear if is not auction type
        txtCountDown(widget.nftCategory),
      ],
    );
  }

  Widget txtCountDown(NFT_CATEGORY nftCategory) {
    if (nftCategory == NFT_CATEGORY.AUCTION) {
      return Positioned(
        top: 119.h,
        left: 30.w,
        child: Container(
          width: 85.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(228, 172, 26, 0.7),
            borderRadius: BorderRadius.all(
              Radius.circular(12.5.r),
            ),
            border: Border.all(
              color: const Color(0xFFFF9E12),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageAssets.ic_clock2,
                width: 12.w,
                height: 12.h,
              ),
              Expanded(
                child: Text(
                  '15:02:22',
                  style: textNormalCustom(
                    AppTheme.getInstance().failTransactionColors(),
                    13.sp,
                    FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Positioned(
        child: Container(),
      );
    }
  }

  Widget isHardNft(NFT_IS_HARD nftIsHard) {
    if (nftIsHard == NFT_IS_HARD.HARD_NFT) {
      return Padding(
        padding: EdgeInsets.only(
          left: 117.w,
        ),
        child: Image.asset(
          ImageAssets.img_hard_nft,
          height: 27.41.h,
          width: 20.08.w,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget isHaveButtonPlayVideo(NFT_IS_VID_OR_IMG nftIsVidOrImg) {
    if (nftIsVidOrImg == NFT_IS_VID_OR_IMG.VIDEO_NFT) {
      return Positioned(
        top: 49.h,
        left: 56.w,
        child: const Center(
          child: Image(
            image: AssetImage(ImageAssets.play_video),
          ),
        ),
      );
    } else {
      return Positioned(child: Container());
    }
  }

  Widget imgNFT() {
    return Container(
      width: 140.w,
      height: 129.h,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/lambo.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  Widget txtTypeNft({required NFT_CATEGORY nftCategory}) {
    switch (nftCategory) {
      case NFT_CATEGORY.SALE:
        return Text(
          S.current.sell,
          style: textNormalCustom(
              AppTheme.getInstance().successTransactionColors(),
              13.sp,
              FontWeight.w600),
        );
      case NFT_CATEGORY.AUCTION:
        return Text(
          S.current.auction,
          style: textNormalCustom(
              AppTheme.getInstance().failTransactionColors(),
              13.sp,
              FontWeight.w600),
        );
      default:
        return Text(
          S.current.pawn,
          style:
              textNormalCustom(const Color(0xff46BCFF), 13.sp, FontWeight.w600),
        );
    }
  }
}
