import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:Dfy/presentation/market_place/create_collection/ui/create_detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CreateCollectionScreen extends StatelessWidget {
  final CreateCollectionBloc bloc;

  const CreateCollectionScreen({Key? key, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.create_collection,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 16.h,
                ),
                child: Text(
                  S.current.soft_nft,
                  style: textLabelNFT,
                ),
              ),
              selectItem(
                item1: nftItem(type: TypeNFT.SOFT_NFT_ERC721, context: context),
                item2:
                    nftItem(type: TypeNFT.SOFT_NFT_ERC1155, context: context),
              ),
              spaceH24,
              Container(
                margin: EdgeInsets.only(
                  bottom: 16.h,
                ),
                child: Text(
                  S.current.hard_nft,
                  style: textLabelNFT,
                ),
              ),
              selectItem(
                item1: nftItem(type: TypeNFT.HARD_NFT_ERC721, context: context),
                item2:
                    nftItem(type: TypeNFT.HARD_NFT_ERC1155, context: context),
              ),
            ],
          ),
        ),
        floatingActionButton: StreamBuilder<TypeNFT>(
            stream: bloc.typeNFTStream,
            initialData: TypeNFT.NONE,
            builder: (context, snapshot) {
              return ButtonLuxury(
                marginHorizontal: 16,
                title: S.current.continue_s,
                isEnable: snapshot.data != TypeNFT.NONE,
                buttonHeight: 64,
                fontSize: 20,
                onTap: () {
                  if (snapshot.data != TypeNFT.NONE) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateDetailCollection(
                          bloc: bloc,
                          typeNFT: snapshot.data ?? TypeNFT.SOFT_NFT_ERC721,
                        ),
                      ),
                    );
                  }
                },
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget selectItem({
    required Widget item1,
    required Widget item2,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          item1,
          item2,
        ],
      ),
    );
  }

  Widget nftItem({
    required TypeNFT type,
    required BuildContext context,
  }) {
    final bool isActive =
        type == TypeNFT.SOFT_NFT_ERC721 || type == TypeNFT.HARD_NFT_ERC721;
    final bool isHardNFT =
        type == TypeNFT.HARD_NFT_ERC721 || type == TypeNFT.HARD_NFT_ERC1155;
    return Stack(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if (isActive) {
                  bloc.changeSelectedItem(type);
                }
              },
              child: SizedBox(
                width: 118.w,
                height: 132.h,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      isActive
                          ? ImageAssets.create_collection_svg
                          : ImageAssets.create_collection_1155,
                    ),
                    if (!isActive)
                      Center(
                        child: Text(
                          S.current.coming_soon,
                          style: titleText(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (isHardNFT)
                      Positioned(
                        top: 0,
                        right: 10,
                        child: sizedSvgImage(
                          w: 21,
                          h: 28,
                          image: ImageAssets.hard_nft_note_svg,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: isActive
                    ? AppTheme.getInstance().whiteColor()
                    : AppTheme.getInstance()
                        .disableRadioColor()
                        .withOpacity(0.5),
              ),
              child: StreamBuilder<TypeNFT>(
                stream: bloc.typeNFTStream,
                initialData: TypeNFT.SOFT_NFT_ERC721,
                builder: (context, snapshot) {
                  return Radio<TypeNFT>(
                    splashRadius: isActive ? null : 0,
                    activeColor: AppTheme.getInstance().fillColor(),
                    value: type,
                    groupValue: bloc.createType,
                    onChanged: (value) {
                      if (isActive) {
                        bloc.changeSelectedItem(
                          value ?? TypeNFT.SOFT_NFT_ERC721,
                        );
                      }
                    },
                  );
                },
              ),
            ),
            Text(
              type.nftName,
              style: textCustom(
                color: isActive
                    ? AppTheme.getInstance().whiteColor()
                    : AppTheme.getInstance().whiteColor().withOpacity(0.5),
              ),
            )
          ],
        ),
      ],
    );
  }
}

enum TypeNFT {
  SOFT_NFT_ERC721,
  SOFT_NFT_ERC1155,
  HARD_NFT_ERC721,
  HARD_NFT_ERC1155,
  NONE,
}

extension TypeNFTExtension on TypeNFT {
  String get nftName {
    switch (this) {
      case TypeNFT.SOFT_NFT_ERC721:
        return 'NFT ERC 721';
      case TypeNFT.SOFT_NFT_ERC1155:
        return 'NFT ERC 1155';
      case TypeNFT.HARD_NFT_ERC721:
        return 'NFT ERC 721';
      case TypeNFT.HARD_NFT_ERC1155:
        return 'NFT ERC 1155';
      default:
        return '';
    }
  }
}
