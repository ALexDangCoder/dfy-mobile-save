import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class FromSwitch1 extends StatelessWidget {
  final bool isCheck;
  final String title;
  final String urlPrefixIcon;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const FromSwitch1({
    Key? key,
    required this.isCheck,
    required this.title,
    required this.urlPrefixIcon,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      //padding: EdgeInsets.symmetric(horizontal: 15.5.w),
      decoration: BoxDecoration(
        color: const Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Center(
        child: ListTileSwitch(
          enabled: false,
          switchScale: 1.0,
          value: isCheck,
          leading: SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset(urlPrefixIcon),
          ),
          onChanged: (value) {
            bLocCreateSeedPhrase.isCheckTouchID.sink.add(value);
          },
          switchActiveColor: AppTheme.getInstance().fillColor(),
          switchType: SwitchType.cupertino,
          title: Text(
            title,
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
