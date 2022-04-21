import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/model/home_pawn/nft_pawn_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NFTItemPawn extends StatefulWidget {
  const NFTItemPawn({
    Key? key,
    required this.cryptoPawnModel,
  }) : super(key: key);

  final CryptoPawnModel cryptoPawnModel;

  @override
  _NFTItemPawnState createState() => _NFTItemPawnState();
}

class _NFTItemPawnState extends State<NFTItemPawn> {
  final formatValue = NumberFormat('###,###,###.###', 'en_US');
  static const int ACTIVE = 1;
  static const int COMPLETED = 2;
  static const int DEFAULT = 3;

  @override
  Widget build(BuildContext context) {
    final nftPawnModel = widget.cryptoPawnModel.nft ?? NFTPawnModel();
    return Stack(
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
                    SizedBox(
                      height: 129.h,
                      width: 140.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: (getTypeImage(
                                  nftPawnModel.fileType.toString(),
                                ) !=
                                TypeImage.VIDEO)
                            ? FadeInImage.assetNetwork(
                                placeholder: ImageAssets.image_loading,
                                image: ApiConstants.BASE_URL_IMAGE+(nftPawnModel.nftAvatarCid ?? nftPawnModel.nftMediaCid.toString()),
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
                                image: ApiConstants.BASE_URL_IMAGE+(nftPawnModel.nftMediaCid ?? nftPawnModel.nftAvatarCid.toString()),
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
                    playVideo(
                      getTypeImage(
                        nftPawnModel.fileType.toString(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 16.h,
                  child: Text(
                    nftPawnModel.nftName ?? '',
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
                Text(
                  getStatus(widget.cryptoPawnModel.status ?? 0),
                  style: textNormalCustom(
                    getColor(widget.cryptoPawnModel.status ?? 0),
                    13,
                    FontWeight.w600,
                  ),
                ),
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
                            if (widget.cryptoPawnModel.supplyCurrency
                                    ?.isNotEmpty ??
                                false)
                              ClipRRect(
                                child: Image.network(
                                  ImageAssets.getUrlToken(
                                    widget.cryptoPawnModel.supplyCurrency ?? '',
                                  ),
                                  fit: BoxFit.cover,
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
                                formatValue.format(
                                  widget.cryptoPawnModel.supplyCurrencyAmount ??
                                      0,
                                ),
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
                        '${nftPawnModel.numberOfCopies ?? 1} '
                        '${S.current.of_all} '
                        '${nftPawnModel.totalOfCopies ?? 1}',
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
      ],
    );
  }

  String getStatus(int type) {
    switch (type) {
      case ACTIVE:
        return S.current.active;
      case COMPLETED:
        return S.current.completed;
      case DEFAULT:
        return S.current.defaults;
      default:
        return '';
    }
  }

  Color getColor(int type) {
    switch (type) {
      case ACTIVE:
        return AppTheme.getInstance().greenMarketColors();
      case COMPLETED:
        return AppTheme.getInstance().blueMarketColors();
      case DEFAULT:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
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

  TypeImage getTypeImage(String type) {
    if (type.toLowerCase().contains('image')) {
      return TypeImage.IMAGE;
    } else {
      return TypeImage.VIDEO;
    }
  }
}
