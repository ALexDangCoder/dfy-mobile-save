import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/hard_nft.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/not_on_market.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/on_auction.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/on_pawn.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/on_sale.dart';
import 'package:Dfy/presentation/detail_collection/ui/check_box_nft_fillter/soft_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterNFT extends StatefulWidget {
  final DetailCollectionBloc collectionBloc;

  const FilterNFT({Key? key, required this.collectionBloc}) : super(key: key);

  @override
  _FilterNFTState createState() => _FilterNFTState();
}

class _FilterNFTState extends State<FilterNFT> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final collectionBloc = widget.collectionBloc;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 9.h,
            ),
            SizedBox(
              height: 5.h,
              child: Center(
                child: Image.asset(
                  ImageAssets.imgRectangle,
                ),
              ),
            ),
            spaceH20,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        S.current.nft_type,
                        style: textNormalCustom(null, 20.sp, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsHardNft(
                            title: S.current.hard_nft,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsSortNft(
                            title: S.current.soft_nft,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        S.current.status,
                        style: textNormalCustom(
                            null, 20.sp, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsOnSale(
                            title: S.current.on_sale,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsOnPawn(
                            title: S.current.on_pawn,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IsOnAuction(
                            title: S.current.on_auction,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                        Expanded(
                          child: IsNotOnMarket(
                            title: S.current.not_on_market,
                            collectionBloc: collectionBloc,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: ButtonLuxury(
                title: S.current.apply,
                isEnable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
