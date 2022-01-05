import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseCustomScrollView extends StatefulWidget {
  const BaseCustomScrollView({
    Key? key,
    required this.content,
    required this.image,
    required this.initHeight,
    required this.leading,
    this.actions = const [],
    required this.title,
    this.tabBar,
    this.tabBarView,
    this.bottomBar,
  }) : super(key: key);
  final List<Widget> content;
  final String image;
  final double initHeight;
  final Widget leading;
  final String title;
  final List<Widget> actions;
  final Widget? tabBar;
  final Widget? tabBarView;
  final Widget? bottomBar;

  @override
  _BaseCustomScrollViewState createState() => _BaseCustomScrollViewState();
}

class _BaseCustomScrollViewState extends State<BaseCustomScrollView> {
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
          backgroundColor: Colors.black,
          bottomNavigationBar: Container(
            color: AppTheme.getInstance().bgBtsColor(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                ),
                border: Border.all(
                  color: AppTheme.getInstance().divideColor(),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: widget.bottomBar,
            ),
          ),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                  BaseAppBar(
                    image: widget.image,
                    title: widget.title,
                    initHeight: widget.initHeight,
                    leading: widget.leading,
                    actions: widget.actions,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: widget.content,
                          ),
                        )
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

class BaseSliverHeader extends SliverPersistentHeaderDelegate {
  final Widget _tabBar;

  BaseSliverHeader(this._tabBar);

  @override
  double get minExtent => 60.h;

  @override
  double get maxExtent => 60.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Column(
      children: [
        Container(
          color: AppTheme.getInstance().bgBtsColor(),
          height: 58.h,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 305.w,
                minWidth: 253.w,
              ),
              child: _tabBar,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(BaseSliverHeader oldDelegate) {
    return false;
  }
}
