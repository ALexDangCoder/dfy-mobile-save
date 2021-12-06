import 'dart:developer';

import 'package:Dfy/domain/model/nft.dart';
import 'package:Dfy/presentation/bts_nft_detail/ui/draggable_nft_detail.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextType {
  RICH,
  NORM,
}

class CardNFT extends StatefulWidget {
  const CardNFT({
    Key? key,
    required this.objNFT,
  }) : super(key: key);
  final NFT objNFT;

  @override
  State<StatefulWidget> createState() => _CardNFTState();
}

class _CardNFTState extends State<CardNFT> {
  late final WalletCubit cubit;

  @override
  void initState() {
    cubit = WalletCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await cubit.getTransactionNFTHistory().then(
              (_) => showBoth(context),
            );
      },
      child: Row(
        children: [
          Container(
            height: 102.h,
            width: 88.w,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(ImageAssets.image_example_pop_up),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }

  void showBoth(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 346.h,
            width: 300.w,
            child: ClipRRect(
              child: Image.asset(ImageAssets.image_example_pop_up),
            ),
          ),
        );
      },
    );

    showModalBottomSheet(
      isDismissible: true,
      barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: NFTDetail(
          nft: widget.objNFT,
          listHistory: cubit.listHistory,
        ),
      ),
    ).whenComplete(() => Navigator.pop(context));
  }
}
