
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  final Widget _tabBar;

  SliverHeader(this._tabBar);

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
          padding: EdgeInsets.only(left: 16.w,right: 16.w),
          color: AppTheme.getInstance().bgBtsColor(),
          height: 44.h,
          child: Center(
            child: _tabBar,
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverHeader oldDelegate) {
    return false;
  }
}