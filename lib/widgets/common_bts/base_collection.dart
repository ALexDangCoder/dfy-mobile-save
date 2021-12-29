import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseCollection extends StatelessWidget {
  final Widget child;
  final TabBar tabBar;
  final Widget body;
  final Function() filterFunc;

  const BaseCollection({
    Key? key,
    required this.tabBar,
    required this.child,
    required this.filterFunc,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48.h,
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          height: 764.h,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: NestedScrollView(
            physics: const ScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: child),
                SliverPersistentHeader(
                  delegate: BaseSliverHeader(tabBar),
                  pinned: true,
                ),
              ];
            },
            body: body,
          ),
        ),
      ],
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 48.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
              ),
              height: 35.h,
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
