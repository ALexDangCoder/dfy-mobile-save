import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/extension/upload_file_controller.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/common_widget.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/dashed_btn_add_img_vid.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class UploadImageWidget extends StatelessWidget {
  final ProvideHardNftCubit cubit;
  final bool showAddMore;

  const UploadImageWidget({
    Key? key,
    required this.cubit,
    this.showAddMore = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<Map<String, String>>(
          stream: cubit.currentFileSubject,
          builder: (ctx, sn) {
            final _path = sn.data?[PATH_OF_FILE] ?? '';
            final _type = sn.data?[TYPE_OF_FILE] ?? '';
            if (_path.isEmpty || _type.isEmpty) {
              return InkWell(
                onTap: () {
                  if (Platform.isIOS) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              cubit.pickMedia(pickImageIos: true);
                            },
                            child: const Text('Image'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              cubit.pickMedia();
                            },
                            child: const Text('Files'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.current.cancel),
                        ),
                      ),
                    );
                  } else {
                    cubit.pickMedia();
                  }
                },
                child: const ButtonDashedAddImageFtVid(),
              );
            } else {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    clipBehavior: Clip.hardEdge,
                    height: 290.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (_type == MEDIA_IMAGE_FILE)
                          Center(
                            child: SizedBox(
                              height: 290.h,
                              child: Image.file(
                                File(_path),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        if (_type == MEDIA_VIDEO_FILE)
                          Center(
                            child: SizedBox(
                              height: 290.h,
                              child: StreamBuilder<VideoPlayerController>(
                                stream: cubit.videoFileSubject,
                                builder: (context, snapshot) {
                                  final _controller = snapshot.data;
                                  if (_controller != null) {
                                    return Stack(
                                      children: [
                                        StreamBuilder<bool>(
                                          stream: cubit.playVideoButtonSubject,
                                          builder: (context, snapshot) {
                                            final _showBtnPlay =
                                                snapshot.data ?? false;
                                            return Visibility(
                                              visible: _showBtnPlay,
                                              child: Center(
                                                child: sizedSvgImage(
                                                  w: 20,
                                                  h: 20,
                                                  image:
                                                      ImageAssets.play_btn_svg,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_controller.value.isPlaying) {
                                              _controller.pause();
                                              cubit.playVideoButtonSubject.sink
                                                  .add(true);
                                            } else {
                                              _controller.play();
                                              cubit.playVideoButtonSubject.sink
                                                  .add(false);
                                            }
                                          },
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
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        if (_type == MEDIA_AUDIO_FILE)
                          Center(
                            child: InkWell(
                              onTap:(){
                                cubit.controlAudio();
                              },
                              child: SizedBox(
                                height: 290.h,
                                width: double.infinity,
                                child: Center(
                                  child: StreamBuilder<bool>(
                                    stream: cubit.isPlayingAudioSubject,
                                    builder: (context, snapshot) {
                                      if (snapshot.data == true) {
                                        return sizedSvgImage(
                                          w: 24,
                                          h: 24,
                                          image: ImageAssets.pause_btn_svg,
                                        );
                                      } else {
                                        return sizedSvgImage(
                                          w: 24,
                                          h: 24,
                                          image: ImageAssets.play_btn_svg,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Visibility(
                          visible: showAddMore,
                          child: positionedBtn(
                            onPressed: () {
                              cubit.removeCurrentImage();
                            },
                            topSpace: 8,
                            rightSpace: 8,
                            size: 24,
                            icon: ImageAssets.deleteMediaFile,
                          ),
                        ),
                        Positioned(
                          top: 127.w,
                          left: 12.w,
                          child: IconButton(
                            onPressed: () {
                              cubit.controlMainImage(isNext: false);
                            },
                            icon: Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.getInstance().whiteDot2(),
                              ),
                              child: Center(
                                child: Image.asset(
                                  ImageAssets.leftArrowMediaFile,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 127.w,
                          right: 12.w,
                          child: IconButton(
                            onPressed: () {
                              cubit.controlMainImage(isNext: true);
                            },
                            icon: Container(
                              width: 36.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.getInstance().whiteDot2(),
                              ),
                              child: Center(
                                child: Image.asset(
                                  ImageAssets.rightArrowMediaFile,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder<List<Map<String, String>>>(
                    stream: cubit.listImagePathSubject,
                    builder: (context, snapshot) {
                      final _listData = snapshot.data ?? [];
                      if (_listData.isNotEmpty) {
                        final List<String> _listPath = [];
                        final List<String> _listType = [];
                        for (final e in _listData) {
                          _listPath.add(e.getStringValue(PATH_OF_FILE));
                          _listType.add(e.getStringValue(TYPE_OF_FILE));
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            spaceH8,
                            if (_listPath.length < 3)
                              Container(
                                height: 85.h,
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _listPath.length,
                                  itemBuilder: (_, index) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 83.h,
                                    width: 105.w,
                                    child:
                                        (_listType[index] == MEDIA_IMAGE_FILE)
                                            ? Image.file(
                                                File(_listPath[index]),
                                                fit: BoxFit.cover,
                                              )
                                            : SvgPicture.asset(
                                                ImageAssets.play_btn_svg,
                                              ),
                                  ),
                                ),
                              )
                            else if (_listPath.length == 3)
                              Container(
                                height: 85.h,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallImageWidget(
                                      _listPath[0],
                                      type: _listType[0],
                                    ),
                                    smallImageWidget(
                                      _listPath[1],
                                      type: _listType[1],
                                    ),
                                    smallImageWidget(
                                      _listPath[2],
                                      type: _listType[2],
                                    ),
                                  ],
                                ),
                              )
                            else
                              Container(
                                height: 85.h,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallImageWidget(
                                      _listPath[0],
                                      type: _listType[0],
                                    ),
                                    smallImageWidget(
                                      _listPath[1],
                                      type: _listType[1],
                                    ),
                                    smallImageWidget(
                                      _listPath[2],
                                      type: _listType[2],
                                      imgCount: _listPath.length - 2,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  spaceH16,
                  StreamBuilder<bool>(
                      stream: cubit.enableButtonUploadImageSubject,
                      builder: (context, snapshot) {
                        bool _isEnable = false;
                        if (showAddMore) {
                          _isEnable = snapshot.data ?? true;
                        } else {
                          _isEnable = showAddMore;
                        }
                        return Visibility(
                          visible: _isEnable,
                          child: btnAdd(
                            isEnable: _isEnable,
                            onTap: () {
                              cubit.pickMedia();
                            },
                            content: 'Add more images',
                          ),
                        );
                      }),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
