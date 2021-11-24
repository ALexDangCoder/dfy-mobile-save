import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultCollectionSearch extends StatelessWidget {
  const ResultCollectionSearch({
    Key? key,
    required this.collection,
  }) : super(key: key);

  final Collection collection;



  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
         decoration: BoxDecoration(
           shape: BoxShape.circle,
         ),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: collection.avatar,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(
            color: AppTheme.getInstance().whiteColor(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            collection.title,
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16.sp,
            ),
          ),
          Text(
            '${collection.items} items',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class ResultNFTSearch extends StatelessWidget {
  const ResultNFTSearch({
    Key? key,
    required this.nftItem,
  }) : super(key: key);

  final NftItem nftItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 46.h,
        width: 46.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(nftItem.image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nftItem.name,
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16.sp,
            ),
          ),
          propertyNFT(nftItem.propertiesNFT),
        ],
      ),
    );
  }

  Widget propertyNFT(TypePropertiesNFT? type) {
    switch (type) {
      case TypePropertiesNFT.PAWN:
        return Text(
          'Pawn',
          style: textNormalCustom(
            AppTheme.getInstance().blueColor(),
            13.sp,
            FontWeight.w600,
          ),
        );
      case TypePropertiesNFT.AUCTION:
        return Text(
          'Auction',
          style: textNormalCustom(
            AppTheme.getInstance().failTransactionColors(),
            13.sp,
            FontWeight.w600,
          ),
        );
      case TypePropertiesNFT.SALE:
        return Text(
          'Sale',
          style: textNormalCustom(
            AppTheme.getInstance().successTransactionColors(),
            13.sp,
            FontWeight.w600,
          ),
        );
      default:
        return Container();
    }
  }
}
