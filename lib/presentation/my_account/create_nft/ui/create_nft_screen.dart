import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNFTScreen extends StatelessWidget {
  final CreateNftCubit cubit;

  const CreateNFTScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: cubit.stateStream,
      textEmpty: '',
      retry: () {
        cubit.getListTypeNFT();
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
                  bloc: cubit,
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

                ///Space bottom + space top + height of the button
                SizedBox(
                  height: (64 + 38 + 24).h,
                )
              ],
            ),
          ),
          floatingActionButton: StreamBuilder<String>(
            stream: null,
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
                    // final _standard =
                    // bloc.getStandardFromID(snapshot.data ?? '');
                    // final _type = bloc.getTypeFromID(snapshot.data ?? '');
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
              cubit.changeId(typeNFTModel.id ?? '');
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
        Flexible(
          child: Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: isActive
                  ? AppTheme.getInstance().whiteColor()
                  : AppTheme.getInstance().disableRadioColor().withOpacity(0.5),
            ),
            child: StreamBuilder<String>(
              stream: cubit.selectIdSubject,
              builder: (context, snapshot) {
                return Radio<String>(
                  splashRadius: isActive ? null : 0,
                  activeColor: AppTheme.getInstance().fillColor(),
                  value: typeNFTModel.id ?? '',
                  groupValue: cubit.selectedType,
                  onChanged: (value) {
                    if (isActive) {
                      cubit.changeId(value ?? '');
                    }
                  },
                );
              },
            ),
          ),
        ),
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
