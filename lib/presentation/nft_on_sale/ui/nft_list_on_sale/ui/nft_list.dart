import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/detail_nft/on_sale_detail.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/filter_bts.dart';
import 'package:Dfy/widgets/nft_detail/nft_detail.dart';
import 'package:Dfy/widgets/nft_item_by_category/nft_type_product.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NFTListOnSale extends StatefulWidget {
  const NFTListOnSale({Key? key}) : super(key: key);

  @override
  _NFTListOnSaleState createState() => _NFTListOnSaleState();
}

class _NFTListOnSaleState extends State<NFTListOnSale> {
  String fakeImage =
      'https://image-us.24h.com.vn/upload/2-2019/images/2019-05-25/1558802221-860-vi-dau-sieu-pham-hoat-hinh-he-doraemon-vua-quen-vua-la-unnamed--8--1558666578-width739height559.png';

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      callback: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return const FilterBts();
          },
        );
      },
      isImage: true,
      title: S.current.nft_on_sale,
      text: ImageAssets.ic_filter,
      child: StaggeredGridView.countBuilder(
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 26.w,
        itemCount: products.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return const OnSale();
                },
              );
            },
            child: products[index],
          );
        },
        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      ),
    );
  }
}

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
