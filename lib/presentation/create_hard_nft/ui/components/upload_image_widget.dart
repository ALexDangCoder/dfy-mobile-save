import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/extension/upload_file_controller.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/common_widget.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/dashed_btn_add_img_vid.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadWidget extends StatelessWidget {
  final ProvideHardNftCubit cubit;

  const UploadWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<String>(
          stream: cubit.currentImagePathSubject,
          builder: (ctx, sn) {
            final _path = sn.data ?? '';
            if (_path.isEmpty) {
              return InkWell(
                onTap: () {
                  cubit.pickMedia();
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
                        Center(
                          child: SizedBox(
                            height: 290.h,
                            child: Image.file(
                              File(_path),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        positionedBtn(
                          onPressed: () {
                            cubit.removeCurrentImage();
                          },
                          topSpace: 8,
                          rightSpace: 8,
                          size: 24,
                          icon: ImageAssets.deleteMediaFile,
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
                  StreamBuilder<List<String>>(
                    stream: cubit.listImagePathSubject,
                    builder: (context, snapshot) {
                      final _listPath = snapshot.data ?? [];
                      if (_listPath.isNotEmpty) {
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
                                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    height: 83.h,
                                    width: 105.w,
                                    child: Image.file(
                                      File(_listPath[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            else if (_listPath.length == 3)
                              Container(
                                height: 85.h,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallImageWidget(_listPath[0]),
                                    smallImageWidget(_listPath[1]),
                                    smallImageWidget(_listPath[2]),
                                  ],
                                ),
                              )
                            else
                              Container(
                                height: 85.h,
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    smallImageWidget(_listPath[0]),
                                    smallImageWidget(_listPath[1]),
                                    smallImageWidget(
                                      _listPath[2],
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
                        final _isEnable = snapshot.data ?? true;
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
                      }
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
