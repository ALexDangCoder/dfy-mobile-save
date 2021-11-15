import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class FromSwitch extends StatelessWidget {
  final bool isCheck;
  final String title;
  final String urlPrefixIcon;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const FromSwitch({
    Key? key,
    required this.isCheck,
    required this.title,
    required this.urlPrefixIcon,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      //padding: EdgeInsets.symmetric(horizontal: 15.5.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Center(
        child: ListTileSwitch(
          switchScale: 1,
          value: isCheck,
          leading: Image.asset(urlPrefixIcon),
          onChanged: (value) {
            bLocCreateSeedPhrase.isCheckAppLock.sink.add(value);
          },
          switchActiveColor: AppTheme.getInstance().fillColor(),
          switchType: SwitchType.cupertino,
          title: Text(
            title,
            style: textNormal(
              Colors.white54,
              16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
