import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/item_checkbox_filter.dart';
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
        clipBehavior: Clip.hardEdge,
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
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 55 / 15,
          ),
          padding: EdgeInsets.only(
            top: 5.h,
            bottom: 5.h,
            left: 15.w,
            right: 15.w,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return ItemCheckBoxFilter();
          },
        ),
      ),
    );
  }
}
