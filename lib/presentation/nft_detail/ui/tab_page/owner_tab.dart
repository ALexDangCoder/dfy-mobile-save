import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerTab extends StatefulWidget {
  const OwnerTab({Key? key, required this.listOwner}) : super(key: key);
  final List<OwnerNft> listOwner;

  @override
  State<OwnerTab> createState() => _OwnerTabState();
}

class _OwnerTabState extends State<OwnerTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.listOwner.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listOwner.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: _buildItemOwner(widget.listOwner[index]),
          );
        },
      );
    } else {
      return Center(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 100.h),
          children: [
            Center(
              child: sizedPngImage(
                w: 94,
                h: 94,
                image: ImageAssets.icNoTransaction,
              ),
            ),
            Center(
              child: Text(
                S.current.no_transaction,
                style: tokenDetailAmount(
                  color: AppTheme.getInstance().currencyDetailTokenColor(),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildItemOwner(OwnerNft ownerNft) {
    final String walletAddress = ownerNft.walletAddress ?? '';
    final bool hasKyc = ownerNft.hasKyc ?? false;
    return BaseItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (hasKyc)
                Image.asset(
                  ImageAssets.ic_user_verified,
                  height: 24.h,
                  width: 24.w,
                )
              else
                Image.asset(
                  ImageAssets.ic_profile_circle,
                  height: 24.h,
                  width: 24.w,
                ),
              spaceW10,
              Text(
                walletAddress.formatAddress(
                  index: walletAddress.isNotEmpty ? 10 : 0,
                ),
                style: richTextWhite
                    .copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    )
                    .copyWith(fontSize: 14.sp),
              ),
            ],
          ),
          spaceH7,
          getStatus(ownerNft),
        ],
      ),
    );
  }

  Widget getStatus(OwnerNft ownerNft) {
    final int marketStatus = ownerNft.marketStatus ?? 0;
    final String price = '${ownerNft.price?.stringNumFormat ?? '0'} '
        '${ownerNft.priceSymbol ?? ''}';
    final String time = ownerNft.timeDuration?.toString() ?? '0';
    final int timeType = ownerNft.timeDurationType ?? 0;
    final String timeDurationType =
        (timeType == 0) ? S.current.week : S.current.month;
    switch (marketStatus) {
      case 0:
        return RichText(
          text: TextSpan(
            text: '1 of 1 not on market',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              14,
              FontWeight.w400,
            ),
          ),
        );
      case 1:
        return RichText(
          text: TextSpan(
            text: '1 of 1 on sale for ',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              14,
              FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: price,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
              TextSpan(
                text: ' each',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      case 2:
        return RichText(
          text: TextSpan(
            text: '1 of 1 on auction for ',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              14,
              FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: price,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      case 3:
        return RichText(
          text: TextSpan(
            text: '1 of 1 on pawn for ',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              14,
              FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: price,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
              TextSpan(
                text: ' each in $time $timeDurationType',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
