import 'package:Dfy/config/resources/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget propertyRow(){
  return Container(
    height: 116.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Expanded(child: Container(height: 200, color: Colors.cyan,),),
        line,
        Expanded(child: Container(height: 200, color: Colors.cyan,),),
      ],
    ),
  );
}