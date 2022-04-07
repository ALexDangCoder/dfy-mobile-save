import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInputBase extends StatefulWidget {
  const FormInputBase({
    Key? key,
    required this.title,
    required this.hintText,
    this.initText,
    required this.validateFun,
    this.textInputType,
  }) : super(key: key);
  final String title;
  final String hintText;
  final String? initText;
  final Function validateFun;
  final TextInputType? textInputType;

  @override
  _FormInputBaseState createState() => _FormInputBaseState();
}

class _FormInputBaseState extends State<FormInputBase> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    if (widget.initText?.isNotEmpty ?? false) {
      textEditingController.text = widget.initText ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: textNormalCustom(
              null,
              16,
              FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
          spaceH4,
          Container(
            height: 64.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Center(
              child: TextFormField(
                keyboardType: widget.textInputType,
                controller: textEditingController,
                maxLength: 100,
                validator: (value) {
                  return widget.validateFun(value);
                },
                cursorColor: AppTheme.getInstance().whiteColor(),
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isCollapsed: true,
                  counterText: '',
                  hintText: widget.hintText,
                  hintStyle: textNormal(
                    AppTheme.getInstance().whiteWithOpacityFireZero(),
                    16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
