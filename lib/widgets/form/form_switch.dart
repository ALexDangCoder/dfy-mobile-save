import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class FromSwitch extends StatefulWidget {
  final bool isCheck;
  final String title;
  final String urlPrefixIcon;

  const FromSwitch({
    Key? key,
    required this.isCheck,
    required this.title,
    required this.urlPrefixIcon,
  }) : super(key: key);

  @override
  State<FromSwitch> createState() => _FromSwitchState();
}

class _FromSwitchState extends State<FromSwitch> {
  bool isCheck1 = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      //padding: EdgeInsets.symmetric(horizontal: 15.5.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: ListTileSwitch(
          switchScale: 1,
          value: isCheck1,
          leading: Image.asset(widget.urlPrefixIcon),
          onChanged: (value) {
            setState(() {
              isCheck1 = value;
            });
          },
          switchActiveColor: AppTheme.getInstance().fillColor(),
          switchType: SwitchType.cupertino,
          title: Text(widget.title,
              style: textNormal(
                AppTheme.getInstance().textThemeColor(),
                16.sp,
              )),
        ),
      ),
    );
  }
}
