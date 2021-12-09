import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSearch extends StatefulWidget {
  final String urlIcon1;
  final WalletCubit bloc;
  final String hint;

  const FormSearch({
    Key? key,
    required this.urlIcon1,
    required this.bloc,
    required this.hint,
  }) : super(key: key);

  @override
  State<FormSearch> createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 336.w,
      height: 46.h,
      margin: EdgeInsets.symmetric(horizontal: 19.w),
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: const Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          Image.asset(
            widget.urlIcon1,
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
                  widget.bloc.textSearch.sink.add(value);
                  widget.bloc.search();
                },
                cursorColor: AppTheme.getInstance().whiteColor(),
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: widget.hint,
                  hintStyle: textNormal(
                    Colors.white.withOpacity(0.5),
                    16.sp,
                  ),
                  border: InputBorder.none,
                ),
                // onFieldSubmitted: ,
              ),
            ),
          ),
          StreamBuilder(
            stream: widget.bloc.textSearch,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return GestureDetector(
                onTap: () {
                  widget.bloc.textSearch.sink.add('');
                  textSearch.text = '';
                  widget.bloc.search();
                  //widget.bloc.sortList(widget.bloc.getListTokenModel.value);
                },
                child: snapshot.data?.isNotEmpty ?? false
                    ? Image.asset(
                        ImageAssets.ic_close,
                        width: 20.w,
                        height: 20.h,
                      )
                    : SizedBox(
                        height: 20.h,
                        width: 20.w,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
