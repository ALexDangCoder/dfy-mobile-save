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
    return NestedScrollView(
      physics: const ScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(child: child),
          SliverPersistentHeader(
            delegate: BaseSliverHeader(tabBar),
            // pinned: ,true
          ),
        ];
      },
      body: body,
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.r,
                    ),
                  ),
                  color: backgroundBottomSheetColor,
                ),
                height: 35.h,
                child: _tabBar,
              ),
            ),
          ),
        ),
        line,
      ],
    );
  }

  @override
  bool shouldRebuild(BaseSliverHeader oldDelegate) {
    return false;
  }
}
