import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabLtvLiquidThres extends StatefulWidget {
  const TabLtvLiquidThres({Key? key}) : super(key: key);

  @override
  _TabLtvLiquidThresState createState() => _TabLtvLiquidThresState();
}

class _TabLtvLiquidThresState extends State<TabLtvLiquidThres> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: 30.h,
      ),

    );
  }
}
