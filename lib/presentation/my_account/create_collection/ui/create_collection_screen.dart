import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCollectionScreen extends StatelessWidget {
  final CreateCollectionCubit bloc;

  const CreateCollectionScreen({Key? key, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.getListTypeNFT();
    return StateStreamLayout(
      stream: bloc.stateStream,
      textEmpty: '',
      retry: () {
        bloc.getListTypeNFT();
      },
      error: AppException('', S.current.something_went_wrong),
      child: BaseBottomSheet(
        title: S.current.create_collection,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.current.soft_nft,
                    style: textLabelNFT,
                  ),
                  StreamBuilder<List<TypeNFTModel>>(
                    stream: bloc.listSoftNFTSubject,
                    builder: (context, snapshot) {
                      final list = snapshot.data ?? [];
                      if (list.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 3.w / 4.h,
                          ),
                          itemBuilder: (context, index) {
                            return nftItem(
                              context: context,
                              typeNFTModel: list[index],
                            );
                          },
                          itemCount: list.length,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  spaceH24,
                  Text(
                    S.current.hard_nft,
                    style: textLabelNFT,
                  ),
                  StreamBuilder<List<TypeNFTModel>>(
                    stream: bloc.listHardNFTSubject,
                    builder: (context, snapshot) {
                      final list = snapshot.data ?? [];
                      if (list.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 3.w / 4.h,
                          ),
                          itemBuilder: (context, index) {
                            return nftItem(
                              context: context,
                              typeNFTModel: list[index],
                            );
                          },
                          itemCount: list.length,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  ///Space bottom + space top + height of the button
                  SizedBox(
                    height: (64 + 38 + 24).h,
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: StreamBuilder<String>(
            stream: bloc.typeNFTStream,
            initialData: '',
            builder: (context, snapshot) {
              final enable = snapshot.data?.isNotEmpty ?? false;
              return ButtonLuxury(
                title: S.current.continue_s,
                isEnable: enable,
                buttonHeight: 64,
                fontSize: 20,
                onTap: () {
                  if (enable) {
                    final _standard =
                        bloc.getStandardFromID(snapshot.data ?? '');
                    final _type = bloc.getTypeFromID(snapshot.data ?? '');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateDetailCollection(
                          bloc: CreateCollectionCubit(),
                          collectionStandard: _standard,
                          collectionType: _type,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
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
    required BuildContext context,
    required TypeNFTModel typeNFTModel,
  }) {
    final bool isActive = typeNFTModel.standard == 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (isActive) {
              bloc.changeSelectedItem(typeNFTModel.id ?? '');
            }
          },
          child: SizedBox(
            width: 118.w,
            height: 132.h,
            child: Stack(
              children: [
                sizedSvgImage(
                  w: 118,
                  h: 132,
                  image: isActive
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
                if (typeNFTModel.type == 1)
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
                : AppTheme.getInstance().disableRadioColor().withOpacity(0.5),
          ),
          child: StreamBuilder<String>(
            stream: bloc.typeNFTStream,
            initialData: '',
            builder: (context, snapshot) {
              return Radio<String>(
                splashRadius: isActive ? null : 0,
                activeColor: AppTheme.getInstance().fillColor(),
                value: typeNFTModel.id ?? '',
                groupValue: bloc.createId,
                onChanged: (value) {
                  if (isActive) {
                    bloc.changeSelectedItem(
                      value ?? '',
                    );
                  }
                },
              );
            },
          ),
        ),
        Text(
          getName(typeNFTModel.name ?? ''),
          style: textCustom(
            color: isActive
                ? AppTheme.getInstance().whiteColor()
                : AppTheme.getInstance().whiteColor().withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

String getName(String name) {
  switch (name) {
    case 'collection 721':
      return 'NFT ERC 721';
    case 'collection 1155':
      return 'NFT ERC 1155';
    default:
      return '';
  }
}
