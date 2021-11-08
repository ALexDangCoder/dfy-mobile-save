import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/scan_qr/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSearch extends StatelessWidget {
  final String urlIcon1;
  final ImportTokenNftBloc bloc;
  final String hint;

  const FormSearch({
    Key? key,
    required this.urlIcon1,
    required this.bloc,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      height: 46.h,
      margin: EdgeInsets.symmetric(horizontal: 19.w),
      padding: const EdgeInsets.only(right: 15, left: 15),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        children: [
          Image.asset(
            urlIcon1,
          ),
          SizedBox(
            width: 11.5.w,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 5.w),
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
        ],
      ),
    );
  }
}
