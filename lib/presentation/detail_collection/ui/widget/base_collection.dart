import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_app_bar_collection.dart';

class BaseCustomScrollViewDetail extends StatefulWidget {
  const BaseCustomScrollViewDetail({
    Key? key,
    required this.content,
    required this.imageCover,
    required this.initHeight,
    required this.leading,
    this.actions = const [],
    required this.title,
    this.tabBar,
    this.tabBarView,
    this.isOwner,
    required this.imageAvatar,
    required this.imageVerified,
  }) : super(key: key);
  final List<Widget> content;
  final String imageCover;
  final String imageAvatar;
  final double initHeight;
  final Widget leading;
  final String title;
  final String imageVerified;
  final bool? isOwner;
  final List<Widget> actions;
  final Widget? tabBar;
  final Widget? tabBarView;

  @override
  _BaseCustomScrollViewState createState() => _BaseCustomScrollViewState();
}

class _BaseCustomScrollViewState extends State<BaseCustomScrollViewDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: widget.isOwner ?? false
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.getInstance()
                              .fillColor()
                              .withOpacity(0.3),
                          spreadRadius: -5,
                          blurRadius: 15,
                          offset:
                              const Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.asset(
                      ImageAssets.img_float_btn,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 764.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: NestedScrollView(
                physics: const ScrollPhysics(),
                headerSliverBuilder: (context, innerScroll) => [
                  BaseAppBarCollection(
                    imageCover: widget.imageCover,
                    title: widget.title,
                    initHeight: widget.initHeight,
                    leading: widget.leading,
                    actions: widget.actions,
                    imageAvatar: widget.imageAvatar,
                    isOwner: widget.isOwner ?? false,
                    imageVerified: widget.imageVerified,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: widget.content,
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: BaseSliverHeader(widget.tabBar ?? Container()),
                    pinned: true,
                  ),
                ],
                body: widget.tabBarView ?? Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
