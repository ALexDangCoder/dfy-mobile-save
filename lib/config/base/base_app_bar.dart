import 'dart:math' as math;

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/views/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class BaseAppBar extends SliverAppBar {
  BaseAppBar({
    Key? key,
    required String image,
    required String title,
    required double initHeight,
    required Widget leading,
    required List<Widget> actions,
    TypeImage? typeImage,
  }) : super(
          key: key,
          backgroundColor: AppTheme.getInstance().bgBtsColor(),
          flexibleSpace: BaseSpace(
            title: title,
            image: image,
            initHeight: initHeight,
            typeImage: typeImage ?? TypeImage.IMAGE,
          ),
          expandedHeight: initHeight,
          pinned: true,
          leading: leading,
          actions: actions,
        );
}

class BaseSpace extends StatefulWidget {
  const BaseSpace({
    Key? key,
    required this.title,
    required this.image,
    required this.initHeight,
    required this.typeImage,
  }) : super(key: key);
  final String title;
  final String image;
  final double initHeight;
  final TypeImage typeImage;

  @override
  _BaseSpaceState createState() => _BaseSpaceState();
}

class _BaseSpaceState extends State<BaseSpace> {
  late VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.typeImage == TypeImage.VIDEO) {
      _controller = VideoPlayerController.network(widget.image);
      _controller!.addListener(() {
        setState(() {});
      });
      _controller!.setLooping(true);
      _controller!.initialize().then((_) => setState(() {}));
      _controller!.play();
    }
  }

  @override
  void dispose() {
    if (widget.typeImage == TypeImage.VIDEO) {
      _controller!.dispose();
    }
    super.dispose();
  }

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
                    widget.title,
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  getImage(context, widget.initHeight),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getImage(BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        if (widget.typeImage == TypeImage.VIDEO) {
          _controller!.value.isPlaying
              ? _controller!.pause()
              : _controller!.play();
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: (widget.typeImage == TypeImage.IMAGE)
                ? CustomImageNetwork(
                    image: widget.image,

                  )
                : VideoPlayer(_controller!),
          ),
          playVideo(widget.typeImage),
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
        style: textNormalCustom(null, 24, FontWeight.w600),
      ),
    );
  }

  Widget playVideo(TypeImage? type) {
    if (type == TypeImage.VIDEO) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 35.h,
          ),
          child: Icon(
            _controller!.value.isPlaying
                ? Icons.pause_circle_outline_sharp
                : Icons.play_circle_outline_sharp,
            size: 40.sp,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
