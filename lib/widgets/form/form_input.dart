import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInput extends StatelessWidget {
  final String urlIcon1;
  final String urlIcon2;
  final ImportTokenBloc bloc;
  final String hint;

  const FormInput({
    Key? key,
    required this.urlIcon1,
    required this.urlIcon2,
    required this.bloc,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 20.h),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            urlIcon1,
          ),
          SizedBox(
            width: 20.5.w,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 8.h),
              child: TextFormField(
                onFieldSubmitted: (value) {},
                cursorColor: Colors.white,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: textNormal(
                    Colors.white54,
                    16.sp,
                  ),
                  border: InputBorder.none,
                ),
                // onFieldSubmitted: ,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              urlIcon2,
            ),
          ),
        ],
      ),
    );
  }
}
