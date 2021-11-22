import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/base_items/nft_detail_on_auction.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/nft_item_by_category/nft_type_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<NftProduct> products = const [
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.AUCTION,
    nftIsHard: NFT_IS_HARD.NON_HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.IMG_NFT,
  ),
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.SALE,
    nftIsHard: NFT_IS_HARD.HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.VIDEO_NFT,
  ),
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.AUCTION,
    nftIsHard: NFT_IS_HARD.HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.VIDEO_NFT,
  ),
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.PAWN,
    nftIsHard: NFT_IS_HARD.HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.VIDEO_NFT,
  ),
];

class GridViewAuction extends StatelessWidget {
  const GridViewAuction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.nft_on_auction,
      isImage: true,
      text: ImageAssets.ic_close,
      callback: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          spaceH24,
          Expanded(
            child: StaggeredGridView.countBuilder(
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 26.w,
              itemCount: 4,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnAuction(),
                      ),
                    );
                  },
                  child: products[index],
                );
              },
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            ),
          ),
        ],
      ),
    );
  }
}
