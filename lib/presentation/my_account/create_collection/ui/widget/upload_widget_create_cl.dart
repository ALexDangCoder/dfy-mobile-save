import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/ui/widget/input_row_widget.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class UploadCreateCollection extends StatelessWidget {
  final CreateCollectionCubit cubit;
  const UploadCreateCollection({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceH22,
        Text(
          S.current.upload_cover_photo,
          style: uploadText,
        ),
        spaceH22,
        StreamBuilder<File>(
          stream: cubit.coverPhotoSubject,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final imageFile = snapshot.data!;
              return Container(
                clipBehavior: Clip.hardEdge,
                height: 133.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: GestureDetector(
                        onTap: () async {
                          await cubit.pickImage(
                            imageType: COVER_PHOTO,
                            tittle: S.current.cover_photo,
                          );
                        },
                        child: sizedSvgImage(
                          w: 28,
                          h: 28,
                          image: ImageAssets.ic_camera_svg,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  await cubit.pickImage(
                    imageType: COVER_PHOTO,
                    tittle: S.current.cover_photo,
                  );
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
        SizedBox(height: 32.h),
        Text(
          S.current.upload_avatar,
          style: uploadText,
        ),
        spaceH22,
        StreamBuilder<File>(
          stream: cubit.avatarSubject,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              final imageFile = snapshot.data!;
              return Center(
                child: SizedBox(
                  height: 100.h,
                  width: 100.h,
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 100.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await cubit.pickImage(
                              imageType: AVATAR_PHOTO,
                              tittle: S.current.upload_avatar,
                            );
                          },
                          child: sizedSvgImage(
                            w: 28,
                            h: 28,
                            image: ImageAssets.ic_camera_svg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await cubit.pickImage(
                        imageType: AVATAR_PHOTO,
                        tittle: S.current.upload_avatar,
                      );
                    },
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      color:
                      AppTheme.getInstance().whiteColor().withOpacity(0.5),
                      strokeWidth: 1.5,
                      dashPattern: const [5],
                      child: SizedBox(
                        height: 100.h,
                        child: Center(
                          child: sizedSvgImage(
                            w: 44,
                            h: 44,
                            image: ImageAssets.icon_add_image_svg,
                          ),
                        ),
                      ),
                    ),
                  ),
                  spaceH12,
                  Center(
                    child: Text(
                      S.current.format_image,
                      style: normalText,
                    ),
                  ),
                ],
              );
            }
          },
        ),
        StreamBuilder<String>(
          stream: cubit.avatarMessSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
        SizedBox(height: 32.h),
        Text(
          S.current.upload_featured_photo,
          style: uploadText,
        ),
        spaceH22,
        GestureDetector(
          onTap: () async {
            await cubit.pickImage(
              imageType: FEATURE_PHOTO,
              tittle: S.current.upload_featured_photo,
            );
          },
          child: StreamBuilder<File>(
            stream: cubit.featurePhotoSubject,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                final imageFile = snapshot.data!;
                return Container(
                  clipBehavior: Clip.hardEdge,
                  height: 172.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              } else {
                return DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(20),
                  color: AppTheme.getInstance().whiteColor().withOpacity(0.5),
                  strokeWidth: 1.5,
                  dashPattern: const [5],
                  child: SizedBox(
                    height: 172.h,
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
                );
              }
            },
          ),
        ),
        StreamBuilder<String>(
          stream: cubit.featurePhotoMessSubject,
          initialData: '',
          builder: (context, snapshot) {
            final mess = snapshot.data ?? '';
            return errorMessage(mess);
          },
        ),
      ],
    );
  }
}
