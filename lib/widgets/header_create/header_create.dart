import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCreate extends StatelessWidget {
  const HeaderCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Image.asset(
            ImageAssets.ic_out
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          width: 66.w,
        ),
        Text(
          S.current.create_wallet,
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,),
        ),
        SizedBox(
          width: 64.w,
        ),
        GestureDetector(
          child: Image.asset(
            ImageAssets.ic_close,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
