import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/nft.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/card_nft.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/remove_nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final NFT nft = NFT(
  'Name of NFT',
  'In fringilla orci facilisis in sed eget nec sollicitudin nullam',
  Standard.ERC_1155,
  'https://medium.com/flutter-community/make-text-styling-more-effective-with-richtext-widget-b0e0cb4771ef',
  'Binance smart chain',
  '0xd07dc426200000415242343423424261d2461d2430',
  '#357594',
);


class NFTItem extends StatefulWidget {
  const NFTItem({
    Key? key,
    required this.symbolUrl,
    required this.nameNFT,
    required this.bloc,
    required this.index,
  }) : super(key: key);
  final String symbolUrl;
  final String nameNFT;
  final WalletCubit bloc;
  final int index;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItem> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              return RemoveNft(
                index: widget.index,
                cubit: widget.bloc,
              );
            },
            isNonBackground: false,
          ),
        );
      },
      child: Column(
        children: [
          Visibility(
            visible: !_customTileExpanded,
            child: Divider(
              height: 1.h,
              color: const Color(0xFF4b4a60),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              leading: Container(
                padding: EdgeInsets.only(
                  left: 10.w,
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
                    Image(
                      width: 28.w,
                      height: 28.h,
                      image: const AssetImage(
                        ImageAssets.ic_symbol,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      widget.nameNFT,
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
                    left: 52.w,
                    right: 26.w,
                    bottom: 16.h,
                  ),
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) =>
                           CardNFT(objNFT: nft,),
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
