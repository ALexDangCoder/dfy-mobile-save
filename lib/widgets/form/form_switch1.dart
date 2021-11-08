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
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      //padding: EdgeInsets.symmetric(horizontal: 15.5.w),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: ListTileSwitch(
          switchScale: 1,
          value: isCheck,
          leading: Image.asset(urlPrefixIcon),
          onChanged: (value) {
            bLocCreateSeedPhrase.isCheckTouchID.sink.add(value);
          },
          switchActiveColor: const Color(0xffE4AC1A),
          switchType: SwitchType.cupertino,
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
