import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class FormSearchBase extends StatefulWidget {
  final String urlIcon;
  final String hint;
  final Function? onTapFunction;
  final Function? onChangedFunction;
  final BehaviorSubject<String> textSearchStream;
  final TextEditingController textSearch;

  const FormSearchBase({
    Key? key,
    required this.urlIcon,
    required this.hint,
    this.onTapFunction,
    this.onChangedFunction,
    required this.textSearchStream,
    required this.textSearch,
  }) : super(key: key);

  @override
  State<FormSearchBase> createState() => _FormSearchBaseState();
}

class _FormSearchBaseState extends State<FormSearchBase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 46.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().backgroundBTSColor(),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          Image.asset(
            widget.urlIcon,
          ),
          SizedBox(
            width: 11.5.w,
          ),
          Expanded(
            child: TextFormField(
              controller: widget.textSearch,
              maxLength: 225,
              onChanged: (value) {
                widget.onChangedFunction!(value);
              },
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 4.h),
                counterText: '',
                hintText: widget.hint,
                hintStyle: textNormal(
                  Colors.white.withOpacity(0.5),
                  16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          StreamBuilder(
            stream: widget.textSearchStream,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return GestureDetector(
                onTap: () {
                  widget.onTapFunction!();
                  widget.textSearch.text = '';
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
