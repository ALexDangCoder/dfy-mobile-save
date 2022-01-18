import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

Widget uploadWidget(CreateNftCubit cubit) {
  return Column(
    children: [
      Text(
        'Upload file',
        style: uploadText,
      ),
      spaceH22,
      StreamBuilder<String>(
        stream: cubit.mediaFileSubject,
        builder: (context, snapshot) {
          final String type = snapshot.data ?? '';
          if (type.isNotEmpty) {
            if (type == 'image') {
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
                        Positioned(
                          top: 8.h,
                          right: 8.h,
                          child: GestureDetector(
                            onTap: () {
                              cubit.clearData();
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
                stream: cubit.videoFileSubject,
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
                              cubit.clearData();
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
                cubit.pickFile();
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
    ],
  );
}
