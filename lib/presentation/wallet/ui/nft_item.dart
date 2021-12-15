import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/collection_nft_info.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/card_nft.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/remove_collection.dart';
import 'package:Dfy/widgets/dialog_remove/remove_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTItem extends StatefulWidget {
  const NFTItem({
    Key? key,
    required this.bloc,
    required this.index,
    required this.walletAddress,
    required this.collectionNft,
  }) : super(key: key);
  final CollectionNft collectionNft;
  final WalletCubit bloc;
  final int index;
  final String walletAddress;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItem> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onLongPress: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              // todo nftAddress
              return RemoveCollection(
                walletAddress: widget.walletAddress,
                index: widget.index,
                cubit: widget.bloc,
                nftAddress: '0xd07dc426200000415242343423424261d2461d2430',
              );
            },
            isNonBackground: false,
          ),
        );
      },
      onPressed: null,
      child: Column(
        children: [
          Visibility(
            visible: !_customTileExpanded,
            child: Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              leading: Container(
                padding: EdgeInsets.only(
                  top: 10.h,
                ),
                child: ImageIcon(
                  _customTileExpanded
                      ? const AssetImage(ImageAssets.ic_line_down)
                      : const AssetImage(ImageAssets.ic_line_right),
                  size: 24,
                  color: Colors.white,
                ),
              ),
              title: SizedBox(
                height: 67.h,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.yellow,
                      radius: 18.r,
                      child: Center(
                        child: Text(
                          widget.collectionNft.symbol!.substring(0, 1),
                          style: textNormalCustom(
                            Colors.black,
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      widget.collectionNft.name!,
                      style: textNormalCustom(
                        Colors.white,
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              onExpansionChanged: (bool expanded) {
                setState(
                  () => _customTileExpanded = expanded,
                );
              },
              controlAffinity: ListTileControlAffinity.leading,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 26.w,
                    bottom: 16.h,
                  ),
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.bloc.listNftInfo.length,
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onLongPress: () {
                          Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) {
                                // todo nftAddress
                                return RemoveNft(
                                  walletAddress: widget.walletAddress,
                                  index: widget.index,
                                  cubit: widget.bloc,
                                  nftAddress:
                                      '0xd07dc426200000415242343423424261d2461d2430',
                                );
                              },
                              isNonBackground: false,
                            ),
                          );
                        },
                        child: CardNFT(
                          objNFT: widget.bloc.listNftInfo[index],
                          walletAddress: widget.walletAddress,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
