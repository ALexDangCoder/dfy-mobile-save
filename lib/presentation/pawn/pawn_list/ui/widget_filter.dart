import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemWidgetFilter extends StatefulWidget {
  const ItemWidgetFilter({Key? key}) : super(key: key);

  @override
  _ItemWidgetFilterState createState() => _ItemWidgetFilterState();
}

class _ItemWidgetFilterState extends State<ItemWidgetFilter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().borderItemColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          border: Border.all(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
        width: 343.h,
        height: 138.w,
      ),
    );
  }
}
