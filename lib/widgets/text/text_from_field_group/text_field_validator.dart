import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldValidator extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool isEnabled;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int maxLine;
  final String? hint;
  final String? suffixText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxInputChar;

  const TextFieldValidator({
    Key? key,
    this.controller,
    this.isEnabled = true,
    this.onChange,
    this.validator,
    this.initialValue,
    this.maxLine = 1,
    this.textInputType,
    this.hint,
    this.suffixText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxInputChar = 256,
  }) : super(key: key);

  @override
  State<TextFieldValidator> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFieldValidator> {
  final key = GlobalKey<FormState>();
  FormProvider? formProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    formProvider = FormProvider.of(context);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (formProvider != null) {
        if (widget.validator != null) {
          final validator =
              widget.validator!(widget.controller?.text ?? '') == null;
          formProvider?.validator.addAll({key: validator});
        } else {
          formProvider?.validator.addAll({key: true});
        }
      }
    });
    if (formProvider != null) {
      formProvider?.validator.addAll({key: true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxInputChar),
        ],
        controller: widget.controller,
        onChanged: (value) {
          if (formProvider != null) {
            formProvider?.validator[key] = key.currentState!.validate();
          }
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        initialValue: widget.initialValue,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLine,
        style: textNormal(
          AppTheme.getInstance().whiteColor(),
          16,
        ),
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          fillColor: AppTheme.getInstance().backgroundBTSColor(),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 21.h),
          counterText: '',
          hintText: widget.hint,
          hintStyle: textNormal(
            Colors.white.withOpacity(0.5),
            16,
          ),
          errorStyle: textNormal(
            Colors.red,
            14,
          ),
          suffixStyle: textCustom(),
          suffixText: widget.suffixText,
          prefixText: widget.prefixText,
          border: InputBorder.none,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
        ),
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
        },
      ),
    );
  }
}
