import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/pick_file_extension.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

Widget uploadWidgetCreateNft(CreateNftCubit cubit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        S.current.upload_file,
        style: uploadText,
      ),
      spaceH22,
      StreamBuilder<String>(
        stream: cubit.mediaFileSubject,
        builder: (context, snapshot) {
          final String type = snapshot.data ?? '';
          if (type.isNotEmpty) {
            if (type == MEDIA_IMAGE_FILE) {
              return StreamBuilder<String>(
                stream: cubit.imageFileSubject,
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
                        closeWidget(
                          onTap: () {
                            cubit.clearMainData();
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              );
            } else if (type == MEDIA_VIDEO_FILE) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<VideoPlayerController>(
                    stream: cubit.videoFileSubject,
                    builder: (context, snapshot) {
                      final _controller = snapshot.data;
                      if (_controller != null) {
                        return Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                    cubit.playVideoButtonSubject.sink.add(true);
                                  }
                                },
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
                                    aspectRatio: _controller.value.aspectRatio,
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
                            ),
                            StreamBuilder<bool>(
                              stream: cubit.playVideoButtonSubject,
                              initialData: true,
                              builder: (context, snapshot) {
                                final showPlayBtn = snapshot.data ?? false;
                                if (showPlayBtn) {
                                  return Positioned.fill(
                                    child: InkWell(
                                      onTap: () {
                                        cubit.playVideoButtonSubject.sink
                                            .add(false);
                                        _controller.play();
                                      },
                                      child: sizedSvgImage(
                                        w: 34,
                                        h: 34,
                                        image: ImageAssets.play_btn_svg,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            closeWidget(
                              onTap: () {
                                cubit.clearMainData();
                              },
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  spaceH24,
                  Text(
                    S.current.upload_cover_photo,
                    style: uploadText,
                  ),
                  spaceH24,
                  StreamBuilder<String>(
                    stream: cubit.coverPhotoSubject,
                    builder: (context, snapshot) {
                      if (snapshot.data?.isNotEmpty ?? false) {
                        final imageFile = File(snapshot.data!);
                        return Container(
                          constraints: BoxConstraints(
                            maxHeight: 212.h,
                            minHeight: 133.h,
                          ),
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().colorTextReset(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              closeWidget(
                                onTap: () {
                                  cubit.clearCoverPhoto();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            await cubit.pickCoverPhoto();
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
                  StreamBuilder<String>(
                    stream: cubit.coverPhotoMessSubject,
                    initialData: '',
                    builder: (context, snapshot) {
                      final mess = snapshot.data ?? '';
                      return errorMessage(mess);
                    },
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<String>(
                    stream: cubit.audioFileSubject,
                    builder: (context, snapshot) {
                      if (snapshot.data?.isNotEmpty ?? false) {
                        return Stack(
                          children: [
                            Container(
                              height: 98.h,
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppTheme.getInstance().colorTextReset(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.controlAudio();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 40.w,
                                    vertical: 20.h,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(19.r),
                                  ),
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
                            closeWidget(
                              onTap: () {
                                cubit.clearMainData();
                              },
                            ),
                          ],
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            await cubit.pickCoverPhoto();
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
                  spaceH24,
                  Text(
                    S.current.upload_cover_photo,
                    style: uploadText,
                  ),
                  spaceH24,
                  StreamBuilder<String>(
                    stream: cubit.coverPhotoSubject,
                    builder: (context, snapshot) {
                      if (snapshot.data?.isNotEmpty ?? false) {
                        final imageFile = File(snapshot.data!);
                        return Container(
                          constraints: BoxConstraints(
                            maxHeight: 212.h,
                            minHeight: 133.h,
                          ),
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().colorTextReset(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              closeWidget(
                                onTap: () {
                                  cubit.clearCoverPhoto();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            await cubit.pickCoverPhoto();
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
                  StreamBuilder<String>(
                    stream: cubit.coverPhotoMessSubject,
                    initialData: '',
                    builder: (context, snapshot) {
                      final mess = snapshot.data ?? '';
                      return errorMessage(mess);
                    },
                  ),
                ],
              );
            }
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.pickFile();
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    color: AppTheme.getInstance().whiteColor().withOpacity(0.5),
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
                              S.current.format_media_file,
                              style: normalText,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<String>(
                  stream: cubit.collectionMessSubject,
                  initialData: '',
                  builder: (context, snapshot) {
                    final mess = snapshot.data ?? '';
                    return errorMessage(mess);
                  },
                ),
              ],
            );
          }
        },
      ),
    ],
  );
}

Widget closeWidget({required Function onTap}) {
  return Positioned(
    top: 8.h,
    right: 8.h,
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: sizedSvgImage(
        w: 24,
        h: 24,
        image: ImageAssets.circle_x_svg,
      ),
    ),
  );
}
