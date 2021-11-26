import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxCustom extends StatelessWidget {
  final String title;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const CheckBoxCustom({
    Key? key,
    required this.title,
    required this.bLocCreateSeedPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w, left: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: StreamBuilder(
              stream: bLocCreateSeedPhrase.isCheckBox1,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                return Transform.scale(
                  scale: 1.sp,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.all(
                      AppTheme.getInstance().fillColor(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    value: snapshot.data ?? false,
                    onChanged: (value) {
                      bLocCreateSeedPhrase.isCheckBox1.sink.add(true);
                      if (snapshot.data ?? false) {
                        bLocCreateSeedPhrase.isCheckBox1.sink.add(false);
                      }

                      bLocCreateSeedPhrase.isButton();
                    },
                    activeColor: AppTheme.getInstance().fillColor(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 4.w,
                top: 3.h,
              ),
              child: Text(
                title,
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  14.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
