import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCreate extends StatelessWidget {
  const HeaderCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Image.asset(
              ImageAssets.ic_out,
              width: 20.w,
              height: 20,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Text(
          S.current.create_new_wallet,
          style: textNormalCustom(
            Colors.white,
            20.sp,
            FontWeight.bold,
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Image.asset(
              ImageAssets.ic_close,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
