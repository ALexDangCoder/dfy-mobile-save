import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavCollection extends StatelessWidget {
  final String items;
  final String owners;
  final String volumeTraded;

  const NavCollection({
    Key? key,
    required this.items,
    required this.owners,
    required this.volumeTraded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      margin: EdgeInsets.only(top: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  items,
                  style: textNormalCustom(
                    null,
                    14.sp,
                    FontWeight.w600,
                  ),
                ),
                spaceH2,
                Text(
                  S.current.items,
                  style: textNormalCustom(
                    null,
                    12.sp,
                    null,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  owners,
                  style: textNormalCustom(
                    null,
                    14.sp,
                    FontWeight.w600,
                  ),
                ),
                spaceH2,
                Text(
                  S.current.owners,
                  style: textNormalCustom(
                    null,
                    12.sp,
                    null,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  volumeTraded,
                  style: textNormalCustom(
                    null,
                    14.sp,
                    FontWeight.w600,
                  ),
                ),
                spaceH2,
                Text(
                  S.current.volume_traded,
                  style: textNormalCustom(
                    null,
                    12.sp,
                    null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
