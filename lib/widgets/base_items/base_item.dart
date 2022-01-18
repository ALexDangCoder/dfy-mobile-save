import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseItem extends StatelessWidget {
  const BaseItem({
    Key? key,
    required this.child,
    this.object,
  }) : super(key: key);
  final Widget child;
  final Object? object;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Container(
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().divideColor(),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
