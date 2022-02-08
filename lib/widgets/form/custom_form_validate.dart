import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormValidate extends StatefulWidget {
  const CustomFormValidate({
    Key? key,
    required this.validatorValue,
    required this.hintText,
    this.prefix,
    this.suffix,
    required this.inputType,
    required this.validator,
    this.onChange,
    this.formatter = const [],
    required this.maxLength,
  }) : super(key: key);
  final String? Function(String? value) validatorValue;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLength;
  final List<TextInputFormatter>? formatter;
  final TextInputType inputType;
  final Function(String)? onChange;
  final Map<GlobalKey, bool> validator;

  @override
  State<CustomFormValidate> createState() => _CustomFormValidateState();
}

class _CustomFormValidateState extends State<CustomFormValidate> {
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.validator.addAll({_key: false});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _key,
        child: TextFormField(
          maxLength: widget.maxLength,
          validator: (value) {
            return widget.validatorValue(value);
          },
          onChanged: (value) {
            if (_key.currentState!.validate() == true) {
              widget.validator[_key] = true;
            } else {
              widget.validator[_key] = false;
            }
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          keyboardType: widget.inputType,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppTheme.getInstance().textThemeColor(),
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16.sp,
          ),
          decoration: InputDecoration(
            counterText: '',
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: AppTheme.getInstance().itemBtsColors(),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: AppTheme.getInstance().itemBtsColors(),
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
            fillColor: AppTheme.getInstance().itemBtsColors(),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: AppTheme.getInstance().itemBtsColors(),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: AppTheme.getInstance().itemBtsColors(),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(
                color: AppTheme.getInstance().itemBtsColors(),
              ),
            ),
            hintText: widget.hintText,
            hintStyle: textNormal(
              AppTheme.getInstance().disableColor(),
              16.sp,
            ),
            suffixIcon: widget.suffix,
            prefixIcon: widget.prefix,
          ),
        ),
      ),
    );
  }
}
