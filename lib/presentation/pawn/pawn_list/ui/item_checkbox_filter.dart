import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCheckBoxFilter extends StatefulWidget {
  const ItemCheckBoxFilter({Key? key}) : super(key: key);

  @override
  State<ItemCheckBoxFilter> createState() => _ItemCheckBoxFilterState();
}

class _ItemCheckBoxFilterState extends State<ItemCheckBoxFilter> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24.w,
          child: Transform.scale(
            scale: 1.34.sp,
            child: Checkbox(
              fillColor: MaterialStateProperty.all(
                AppTheme.getInstance().fillColor(),
              ),
              checkColor: AppTheme.getInstance().whiteColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              side: BorderSide(
                width: 1.w,
                color: AppTheme.getInstance().whiteColor(),
              ),
              value: isCheck,
              onChanged: (value) {
                isCheck = value ?? false;
                setState(() {});
              },
            ),
          ),
        ),
        spaceW4,
        Image.asset(
          ImageAssets.ic_dfy,
          width: 20.w,
          height: 20.w,
          fit: BoxFit.fill,
        ),
        spaceW4,
        Text(
          'DFY',
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
        )
      ],
    );
  }
}
