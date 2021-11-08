import 'package:Dfy/config/resources/image_asset.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTItem extends StatefulWidget {
  const NFTItem({Key? key, required this.symbolUrl, required this.nameNFT})
      : super(key: key);
  final String symbolUrl;
  final String nameNFT;

  @override
  _NFTItemState createState() => _NFTItemState();
}

class _NFTItemState extends State<NFTItem> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                top: 10.w,
              ),
              child: ImageIcon(
                _customTileExpanded
                    ? const AssetImage(ImageAssets.icLineDown)
                    : const AssetImage(ImageAssets.icLineRight),
                size: 24.sp,
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
                      ImageAssets.symbol,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'DeFi For You',
                    style: textNormalCustom(
                      Colors.white,
                      20.sp,
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
              ListTile(
                title: Text(
                  'This is tile number 3',
                  style: textNormalCustom(
                    Colors.white,
                    24.sp,
                    FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
