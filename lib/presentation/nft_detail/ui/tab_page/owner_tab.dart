import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerTab extends StatelessWidget {
  const OwnerTab({Key? key, required this.listOwner}) : super(key: key);
  final List<OwnerNft> listOwner;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listOwner.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: _buildItemOwner(listOwner[index]),
        );
      },
    );
  }

  Widget _buildItemOwner(OwnerNft ownerNft) {
    final String walletAddress = ownerNft.walletAddress ?? '';
    return BaseItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: walletAddress.formatAddress(
                    index: walletAddress.isNotEmpty ? 10 : 0,
                  ),
                  style: richTextWhite.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
    final String timeDurationType = (timeType == 0) ? 'weeks' : 'month';
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
            text: '1 of 1 on sale for',
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
                text: 'each',
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
            text: '1 of 1 on pawn for',
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
                text: 'each in $time $timeDurationType',
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
}
