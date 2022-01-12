import 'dart:math' as math;

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseAppBarCollection extends SliverAppBar {
  BaseAppBarCollection({
    Key? key,
    required String imageCover,
    required String imageAvatar,
    required String imageVerified,
    required bool isOwner,
    required String title,
    required double initHeight,
    required Widget leading,
    required List<Widget> actions,
  }) : super(
          key: key,
          backgroundColor: AppTheme.getInstance().bgBtsColor(),
          flexibleSpace: BaseSpace(
            title: title,
            imageCover: imageCover,
            initHeight: initHeight,
            imageAvatar: imageAvatar,
            isOwner: isOwner,
            imageVerified: imageVerified,
          ),
          expandedHeight: initHeight,
          pinned: true,
          leading: leading,
          actions: actions,
        );
}

class BaseSpace extends StatelessWidget {
  const BaseSpace({
    Key? key,
    required this.title,
    required this.initHeight,
    required this.imageAvatar,
    required this.imageCover,
    required this.isOwner,
    required this.imageVerified,
  }) : super(key: key);
  final String title;
  final String imageAvatar;
  final String imageCover;
  final bool isOwner;
  final double initHeight;
  final String imageVerified;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings!.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 8.h,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: 1 - opacity,
                  child: getTitle(
                    title,
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: getImage(context, initHeight),
            ),
          ],
        );
      },
    );
  }

  Widget getImage(BuildContext context, double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CachedNetworkImage(
            fit: BoxFit.cover,
            width: double.infinity,
            height: 145.h,
            errorWidget: (context, url, error) => Container(
              color: AppTheme.getInstance().selectDialogColor(),
            ),
            imageUrl: imageCover,
          ),
          Positioned(
            top: 105.h,
            child: Stack(
              children: [
                Container(
                  height: 80.w,
                  width: 80.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.getInstance().bgBtsColor(),
                      width: 6.w,
                    ),
                  ),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 74.w,
                    height: 74.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageAvatar,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: AppTheme.getInstance().selectDialogColor(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6.h,
                  right: 6.w,
                  child: isOwner
                      ? Image.asset(imageVerified)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 8.h),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: textNormalCustom(null, 20, FontWeight.bold),
      ),
    );
  }
}
