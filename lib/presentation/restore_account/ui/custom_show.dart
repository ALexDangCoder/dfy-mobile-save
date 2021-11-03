import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/restore_account/bloc/state.dart';
import 'package:Dfy/presentation/restore_account/bloc/string_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, required this.cubit}) : super(key: key);
  final StringCubit cubit;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final List<String> text = ['Seed phrase', 'Private key'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.h,
      width: 323.w,
      decoration: const BoxDecoration(
        color: Color(0xff585782),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () {
              widget.cubit.selectSeed(text[0]);
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 323.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text[0],
                  style: textNormal(null, 16.sp),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GestureDetector(
            onTap: () {
              widget.cubit.selectPrivate(text[1]);

              //widget.cubit.hide();
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.w),
              height: 44.h,
              width: 323.w,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text[1],
                  style: textNormal(null, 16.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
