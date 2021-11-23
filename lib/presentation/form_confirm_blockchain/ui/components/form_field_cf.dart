import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormFieldBlockChain extends StatelessWidget {
  const FormFieldBlockChain({Key? key, required this.txtController})
      : super(key: key);
  final TextEditingController txtController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.only(left: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.current.gas_limit,
            style: textNormalCustom(
              Colors.white,
              16.sp,
              FontWeight.w400,
            ),
          ),
          Expanded(
            child: Container(
              width: 178.w,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
                color: AppTheme.getInstance().itemBtsColors(),
              ),
              child: TextFormField(
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                controller: txtController,
                style: textNormalCustom(
                  Colors.white,
                  16.sp,
                  FontWeight.w400,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintStyle: textNormal(
                    Colors.grey,
                    16,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  //todo
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
