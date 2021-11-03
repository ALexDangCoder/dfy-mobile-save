import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckBoxCustom2 extends StatelessWidget {
  final String title;
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

  const CheckBoxCustom2(
      {Key? key, required this.title, required this.bLocCreateSeedPhrase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.w, left: 26.w),
      child: Row(
        children: [
          StreamBuilder(
              stream: bLocCreateSeedPhrase.isCheckBox2,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                return Checkbox(
                  fillColor: MaterialStateProperty.all(const Color(0xffE4AC1A)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  value: snapshot.data ?? false,
                  onChanged: (value) {
                    bLocCreateSeedPhrase.isCheckBox2.sink.add(true);
                    if(snapshot.data??false){
                      bLocCreateSeedPhrase.isCheckBox2.sink.add(false);
                    }
                  },
                  activeColor: const Color(0xffE4AC1A),
                );
              }),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          )
        ],
      ),
    );
  }
}
