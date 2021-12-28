import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_on_pawn/ui/detail_nft_on_pawn/detail_nft_on_pawn.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/filter_bts.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/nft_item_by_category/nft_type_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NftListOnPawn extends StatefulWidget {
  const NftListOnPawn({Key? key}) : super(key: key);

  @override
  _NftListOnPawnState createState() => _NftListOnPawnState();
}

class _NftListOnPawnState extends State<NftListOnPawn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: BaseBottomSheet(
          onRightClick: () {
            showModalBottomSheet(
              backgroundColor: Colors.black,
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return const FilterBts(); //use base filter nft_on_sale
              },
            );
          },
          title: S.current.nft_on_pawn,
          isImage: true,
          text: ImageAssets.ic_filter,
          child: Container(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: StaggeredGridView.countBuilder(
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 26.w,
              itemCount: products.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.black,
                      isScrollControlled: true,
                      context: context,
                      builder: (_) {
                        return const OnPawn();
                      },
                    );
                  },
                  child: products[index],
                );
              },
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            ),
          ),
        ),
      ),
    );
  }
}

List<NftProduct> products = const [
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.PAWN,
    nftIsHard: NFT_IS_HARD.NON_HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.IMG_NFT,
  ),
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.PAWN,
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
  NftProduct(
    nftName: 'Name of NFT',
    price: 10000,
    nftCategory: NFT_CATEGORY.PAWN,
    nftIsHard: NFT_IS_HARD.HARD_NFT,
    nftIsVidOrImg: NFT_IS_VID_OR_IMG.VIDEO_NFT,
  ),
];
