import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/create_detail_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNFTScreen extends StatefulWidget {
  final CreateNftCubit cubit;

  const CreateNFTScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CreateNFTScreen> createState() => _CreateNFTScreenState();
}

class _CreateNFTScreenState extends State<CreateNFTScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: widget.cubit.stateStream,
      textEmpty: '',
      retry: () {
        widget.cubit.getListTypeNFT();
      },
      error: AppException('', S.current.something_went_wrong),
      child: BaseBottomSheet(
        title: S.current.create_nft,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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

                BlocBuilder<CreateNftCubit, CreateNftState>(
                  bloc: widget.cubit,
                  builder: (context, state) {
                    if (state is TypeNFT) {
                      final List<TypeNFTModel> list = state.listSoftNft;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return nftItem(
                            context: context,
                            typeNFTModel: list[index],
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                spaceH24,
                Text(
                  'Defi For You system has not supported NFT transactions on the ERC-1155 standard',
                  style: textCustom(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),

                ///Space bottom + space top + height of the button
                SizedBox(
                  height: (64 + 38 + 24).h,
                )
              ],
            ),
          ),
          floatingActionButton: StreamBuilder<String>(
            stream: widget.cubit.selectIdSubject,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateDetailNFT(
                          cubit: CreateNftCubit(),
                          nftType: widget.cubit.selectedNftType,
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

  Widget nftItem({
    required BuildContext context,
    required TypeNFTModel typeNFTModel,
  }) {
    final bool isActive = typeNFTModel.standard == 0;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isActive) {
              widget.cubit.changeId(typeNFTModel.id ?? '');
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
        spaceH12,
        Flexible(
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: isActive
                  ? AppTheme.getInstance().whiteColor()
                  : AppTheme.getInstance().disableRadioColor().withOpacity(0.5),
            ),
            child: StreamBuilder<String>(
              stream: widget.cubit.selectIdSubject,
              builder: (context, snapshot) {
                return Radio<String>(
                  splashRadius: isActive ? null : 0,
                  activeColor: AppTheme.getInstance().fillColor(),
                  value: typeNFTModel.id ?? '',
                  groupValue: widget.cubit.selectedId,
                  onChanged: (value) {
                    if (isActive) {
                      widget.cubit.changeId(value ?? '');
                    }
                  },
                );
              },
            ),
          ),
        ),
        spaceH12,
        Text(
          getName(typeNFTModel.name ?? ''),
          style: textCustom(
            color: isActive
                ? AppTheme.getInstance().whiteColor()
                : AppTheme.getInstance().whiteColor().withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
