import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_MEDIA_WIDGET {
  MAIN,
  PART,
  PART_MORE, //WITH ADD BUTTON
}

class MediaFileWidget extends StatelessWidget {
  const MediaFileWidget({
    Key? key,
    required this.mediaWidget,
    required this.typeMedia,
    required this.cubit,
  }) : super(key: key);
  final Widget mediaWidget;
  final TYPE_MEDIA_WIDGET typeMedia;
  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (typeMedia == TYPE_MEDIA_WIDGET.MAIN) {
      return Container(
        height: 290.h,
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: mediaWidget,
            ),
            deleteBtn(topSpace: 8, rightSpace: 8, isMainWidget: true),
            Positioned(
              top: 127.w,
              left: 12.w,
              child: IconButton(
                onPressed: (){
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
                onPressed: (){
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
      );
    } else if (typeMedia == TYPE_MEDIA_WIDGET.PART) {
      return Container(
        height: 290.h,
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: mediaWidget,
            ),
            deleteBtn(
              topSpace: 4,
              rightSpace: 4,
              isMainWidget: false,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 290.h,
        width: 343.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: mediaWidget,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text('More'),
              ),
            )
          ],
        ),
      );
    }
  }

  //stack
  Positioned deleteBtn({
    required double topSpace,
    required double rightSpace,
    required bool isMainWidget,
  }) {
    return Positioned(
      top: topSpace.h,
      right: rightSpace.h,
      child: SizedBox(
        height: isMainWidget ? 24.h : 16.h,
        width: isMainWidget ? 24.h : 16.h,
        child: Image.asset(ImageAssets.deleteMediaFile),
      ),
    );
  }
}
