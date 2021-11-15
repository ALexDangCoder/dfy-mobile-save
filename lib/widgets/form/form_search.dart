import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSearch extends StatelessWidget {
  final String urlIcon1;
  final ImportTokenNftBloc bloc;
  final String hint;

  FormSearch({
    Key? key,
    required this.urlIcon1,
    required this.bloc,
    required this.hint,
  }) : super(key: key);
  final textSearch = TextEditingController();

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
                controller: textSearch,
                maxLength: 20,
                onChanged: (value) {
                  bloc.textSearch.sink.add(value);
                  bloc.search();
                },
                cursorColor: Colors.white,
                style: textNormal(
                  Colors.white54,
                  16.sp,
                ),
                decoration: InputDecoration(
                  counterText: '',
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
            onTap: () {
              bloc.textSearch.sink.add('');
              textSearch.text = '';
              bloc.search();
            },
            child: Image.asset(
              url_ic_close,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
