import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/presentation/bts_nft_detail/ui/draggable_nft_detail.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    required this.walletAddress,
  }) : super(key: key);
  final NftInfo objNFT;
  final String walletAddress;

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
              (_) => showBoth(context, widget.objNFT.img ?? ''),
            );
      },
      child: Row(
        children: [
          Container(
            height: 102.h,
            width: 92.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.objNFT.img ?? ''),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(
                10.r,
              ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
        ],
      ),
    );
  }

  void showBoth(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 346.h,
            width: 300.w,
            child: ClipRRect(
              child: CachedNetworkImage(
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                ),
                imageUrl: url,
                fit: BoxFit.cover,
              ),
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
          nftInfo: widget.objNFT,
          listHistory: cubit.listHistory,
          walletAddress: widget.walletAddress,
        ),
      ),
    ).whenComplete(() => Navigator.pop(context));
  }
}
