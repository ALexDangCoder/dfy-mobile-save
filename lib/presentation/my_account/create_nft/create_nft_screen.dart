import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/select_nft_type_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/ui/create_detail_nft.dart';
import 'package:Dfy/presentation/on_boarding/ui/on_boarding.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNFTScreen extends StatefulWidget {
  final CreateNftCubit cubit;

  const CreateNFTScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  State<CreateNFTScreen> createState() => _CreateNFTScreenState();
}

class _CreateNFTScreenState extends State<CreateNFTScreen> {
  @override
  void initState() {
    widget.cubit.getListTypeNFT();
    super.initState();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    super.dispose();
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
          body: SingleChildScrollView(
            child: Container(
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
                  StreamBuilder<List<TypeNFTModel>>(
                      stream: widget.cubit.listNftSubject,
                      builder: (context, snapshot) {
                        final List<TypeNFTModel> data = snapshot.data ?? [];
                        final list =
                            data.where((element) => element.type == 0).toList();
                        if (list.isNotEmpty) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                      }),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 16.h,
                    ),
                    child: Text(
                      S.current.hard_nft,
                      style: textLabelNFT,
                    ),
                  ),
                  StreamBuilder<List<TypeNFTModel>>(
                    stream: widget.cubit.listNftSubject,
                    builder: (context, snapshot) {
                      final List<TypeNFTModel> data = snapshot.data ?? [];
                      final list =
                          data.where((element) => element.type == 1).toList();
                      if (list.isNotEmpty) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                    S.current.not_supported_standard,
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
                    if (widget.cubit.selectedNftType == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateDetailNFT(
                            cubit: CreateNftCubit(),
                            nftType: widget.cubit.selectedNftType,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnBoardingScreen(),
                        ),
                      );
                    }
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
      mainAxisSize: MainAxisSize.min,
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
        Theme(
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
