import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/presentation/bts_nft_detail/ui/draggable_nft_detail.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardNFT extends StatefulWidget {
  const CardNFT({
    Key? key,
    required this.objNFT,
    required this.walletAddress,
    required this.walletCubit,
    required this.walletName,
  }) : super(key: key);
  final NftInfo objNFT;
  final String walletAddress;
  final WalletCubit walletCubit;
  final String walletName;

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
        await cubit
            .getHistory(
              collectionAddress: widget.objNFT.contract ?? '',
              nftTokenId: widget.objNFT.id ?? '',
            )
            .then((value) => showBoth(context, widget.objNFT.img ?? '', value));
      },
      child: Row(
        children: [
          SizedBox(
            height: 102.h,
            width: 92.w,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              child: (widget.objNFT.img ?? '').isEmpty
                  ? Container(
                      color: AppTheme.getInstance().selectDialogColor(),
                      child: Center(
                        child: Text(
                          '#${widget.objNFT.id ?? 'NFT ID'}',
                          style: textNormal(null, null),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.getInstance().bgBtsColor(),
                        ),
                      ),
                      imageUrl: widget.objNFT.img ?? '',
                      fit: BoxFit.cover,
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

  void showBoth(BuildContext context, String url, List<HistoryNFT> list) {
    showDialog(
      context: context,
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 346.h,
            width: 300.w,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: url.isEmpty
                  ? Container(
                      color: AppTheme.getInstance().selectDialogColor(),
                      child: Center(
                        child: Text(
                          '#${widget.objNFT.id ?? 'NFT ID'}',
                          style: textNormal(null, 20),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
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
          listHistory: list,
          walletAddress: widget.walletAddress,
          nameWallet: widget.walletName,
          walletCubit: widget.walletCubit,
        ),
      ),
    ).whenComplete(() => Navigator.pop(context));
  }
}
