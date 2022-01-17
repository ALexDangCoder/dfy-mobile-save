import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/ui/widget/properties_row.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:video_player/video_player.dart';

class CreateDetailNFT extends StatefulWidget {
  final CreateNftCubit cubit;
  final int nftType;

  const CreateDetailNFT({Key? key, required this.cubit, required this.nftType})
      : super(key: key);

  @override
  State<CreateDetailNFT> createState() => _CreateDetailNFTState();
}

class _CreateDetailNFTState extends State<CreateDetailNFT> {
  late TextEditingController nameCollectionController;
  late TextEditingController descriptionCollectionController;
  late TextEditingController royaltyCollectionController;

  @override
  void initState() {
    nameCollectionController = TextEditingController();
    descriptionCollectionController = TextEditingController();
    royaltyCollectionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    widget.cubit.dispose();
    nameCollectionController.dispose();
    descriptionCollectionController.dispose();
    royaltyCollectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BaseBottomSheet(
        resizeBottomInset: true,
        title: S.current.create_collection,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload file',
                  style: uploadText,
                ),
                spaceH22,
                StreamBuilder<String>(
                  stream: widget.cubit.mediaFileSubject,
                  builder: (context, snapshot) {
                    final String type = snapshot.data ?? '';
                    if (type.isNotEmpty) {
                      if (type == 'image') {
                        return StreamBuilder<String>(
                          stream: widget.cubit.imageFileSubject,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final File mediaFile = File(snapshot.data ?? '');
                              return Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 113.h,
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Image.file(
                                          mediaFile,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.h,
                                    right: 8.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.cubit.clearData();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.getInstance()
                                              .whiteColor()
                                              .withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.clear),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      } else if (type == 'video') {
                        return StreamBuilder<VideoPlayerController>(
                          stream: widget.cubit.videoFileSubject,
                          builder: (context, snapshot) {
                            final _controller = snapshot.data;
                            if (_controller != null) {
                              return Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 113.h,
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: <Widget>[
                                            VideoPlayer(_controller),
                                            VideoProgressIndicator(
                                              _controller,
                                              allowScrubbing: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.h,
                                    right: 8.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.cubit.clearData();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppTheme.getInstance()
                                              .whiteColor()
                                              .withOpacity(0.6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.clear),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        );
                      } else {
                        return Container(
                          color: Colors.cyan,
                        );
                      }
                    } else {
                      return GestureDetector(
                        onTap: () {
                          widget.cubit.pickFile();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(20),
                          color: AppTheme.getInstance()
                              .whiteColor()
                              .withOpacity(0.5),
                          strokeWidth: 1.5,
                          dashPattern: const [5],
                          child: SizedBox(
                            height: 133.h,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  sizedSvgImage(
                                    w: 44,
                                    h: 44,
                                    image: ImageAssets.icon_add_image_svg,
                                  ),
                                  spaceH16,
                                  Text(
                                    S.current.format_image,
                                    style: normalText,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                // StreamBuilder<String>(
                //   stream: widget.bloc.avatarMessSubject,
                //   initialData: '',
                //   builder: (context, snapshot) {
                //     final mess = snapshot.data ?? '';
                //     return errorMessage(mess);
                //   },
                // ),
                spaceH16,
                InputRow(
                  hint: 'Name of NFT',
                  leadImg: ImageAssets.ic_edit_square_svg,
                  textController: nameCollectionController,
                  onChange: (value) {},
                ),
                InputRow(
                  hint: S.current.description,
                  leadImg: ImageAssets.ic_edit_square_svg,
                  textController: nameCollectionController,
                  onChange: (value) {},
                ),
                InputRow(
                  textController: royaltyCollectionController,
                  suffixes: '%',
                  onChange: (value) {},
                  leadImg: ImageAssets.ic_round_percent_svg,
                  hint: S.current.royalties,
                  img2: ImageAssets.ic_round_i,
                  inputType: TextInputType.number,
                  onImageTap: () {},
                ),
                spaceH16,
                Text(
                  'Properties (add more trait for your NFT)',
                  style: textCustom(
                    weight: FontWeight.w600,
                  ),
                ),
                spaceH16,
                propertyRow(),
                StreamBuilder<bool>(
                  stream: null,
                  initialData: false,
                  builder: (context, snapshot) {
                    final statusButton = snapshot.data ?? false;
                    return ButtonLuxury(
                      marginHorizontal: 16.w,
                      title: S.current.create,
                      isEnable: statusButton,
                      buttonHeight: 64,
                      fontSize: 20,
                      onTap: () {
                        if (statusButton) {
                        } else {}
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
