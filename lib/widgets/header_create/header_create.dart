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
          child: Image.asset(ImageAssets.ic_out),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Text(
          S.current.create_wallet,
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          child: Image.asset(
            ImageAssets.ic_close,
          ),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.main,
              (route) => route.isFirst,
            );
          },
        ),
      ],
    );
  }
}
