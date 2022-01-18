import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BidTab extends StatefulWidget {
  const BidTab({Key? key, required this.listBidding, required this.symbolToken})
      : super(key: key);
  final List<BiddingNft> listBidding;
  final String symbolToken;

  @override
  State<BidTab> createState() => _BidTabState();
}

class _BidTabState extends State<BidTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const ScrollPhysics(),
      itemCount: widget.listBidding.length,
      itemBuilder: (context, index) {
        return _buildItemBid(widget.listBidding[index]);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildItemBid(BiddingNft biddingNft) {
    return BaseItem(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: biddingNft.biddingWallet!.isNotEmpty
                            ? '${biddingNft.biddingWallet!.handleString()} bid'
                            : '',
                        style: richTextWhite.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH7,
                Text(
                  formatDateTime.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      biddingNft.time ?? 0,
                    ),
                  ),
                  style: textNormalCustom(
                    Colors.white.withOpacity(0.5),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    sizedSvgImage(
                      w: 20,
                      h: 20,
                      image: ImageAssets.ic_token_dfy_svg,
                    ),
                    spaceW4,
                    Text(
                      '${biddingNft.bidValue} ${widget.symbolToken}',
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                spaceH7,
                statusBid(biddingNft.status ?? 0)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget statusBid(int status) {
    switch (status) {
      case 2:
        return Text(
          'Out bid',
          style: textNormalCustom(
            Colors.red,
            14,
            FontWeight.w600,
          ),
        );
      case 1:
        return Text(
          'Winning',
          style: textNormalCustom(
            Colors.green,
            14,
            FontWeight.w600,
          ),
        );
      case 4:
        return Text(
          'Won',
          style: textNormalCustom(
            Colors.yellow,
            14,
            FontWeight.w600,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}

