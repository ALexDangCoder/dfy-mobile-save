import 'dart:math' as math;

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseAppBar extends SliverAppBar {
  BaseAppBar({
    Key? key,
    required String image,
    required String title,
    required double initHeight,
    required Widget leading,
    required List<Widget> actions,
  }) : super(
          key: key,
          backgroundColor: AppTheme.getInstance().bgBtsColor(),
          flexibleSpace: BaseSpace(
            title: title,
            image: image,
            initHeight: initHeight,
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
    required this.image,
    required this.initHeight,
  }) : super(key: key);
  final String title;
  final String image;
  final double initHeight;

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
              margin: const EdgeInsets.only(bottom: 8),
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
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getImage(context, initHeight),
                ],
              ),
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
      child: Image(
        image: CachedNetworkImageProvider(image),
        fit: BoxFit.cover,
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
        style: textNormalCustom(null, 24, FontWeight.w600),
      ),
    );
  }
}
