import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/nft_view/nft_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTListOnSale extends StatefulWidget {
  const NFTListOnSale({Key? key}) : super(key: key);

  @override
  _NFTListOnSaleState createState() => _NFTListOnSaleState();
}

class _NFTListOnSaleState extends State<NFTListOnSale> {
  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      isImage: true,
      title: S.current.nft_on_sale,
      text: ImageAssets.ic_filter,
      child: GridView.count(
        ///main horizontal, cross vertical
        mainAxisSpacing: 25.w,
        crossAxisSpacing: 20.h,
        crossAxisCount: 2,
        children: [
          NFTItemWidget(
            name: 'Name of NFT',
            price: 90000.22,
            typeImage: TypeImage.IMAGE,
            propertiesNFT: TypePropertiesNFT.SALE,
          ),
          NFTItemWidget(
            name: 'Name of NFT',
            price: 90000.22,
            typeImage: TypeImage.IMAGE,
            propertiesNFT: TypePropertiesNFT.SALE,
          ),
        ],
      ),
    );
  }
}
