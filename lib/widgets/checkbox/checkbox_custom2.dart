import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxCustom2 extends StatelessWidget {
  final String title;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const CheckBoxCustom2({
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
          StreamBuilder(
            stream: bLocCreateSeedPhrase.isCheckBox2,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              bLocCreateSeedPhrase.getIsSeedPhraseImport2();
              return Checkbox(
                fillColor: MaterialStateProperty.all(
                  AppTheme.getInstance().fillColor(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                value: snapshot.data ?? false,
                onChanged: (value) {
                  bLocCreateSeedPhrase.isCheckBox2.sink.add(true);
                  if (snapshot.data ?? false) {
                    bLocCreateSeedPhrase.isCheckBox2.sink.add(false);
                  }
                },
                activeColor: AppTheme.getInstance().fillColor(),
              );
            },
          ),
          Expanded(
            child: Text(
              title,
              style: textNormal(
                AppTheme.getInstance().textThemeColor(),
                14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
